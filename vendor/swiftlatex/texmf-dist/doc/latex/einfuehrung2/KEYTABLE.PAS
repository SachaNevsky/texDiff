unit KeyTable;

{$I-,V-,X+}
interface

uses Dos, Drivers, Views, Editors;

const
  N            = 33;
  evInvalidKey = 1024; { entspricht /$2^{10}$/ }
  edNoKeyTab   = 11;
  kbBlank      = $3920;

 function  ReadKeyTable:  boolean;
 function  EditKeyTable:  boolean;
 procedure  ShowKeyTable;
 procedure GetComm (var Pos: Word; var E: TEvent);

 implementation

 var T: array [0..199] of record
      k1,k2,cm:  word
     end;
   top: integer;
   ShiftState: byte absolute  $40:$17;

 const Commands: array [0..N-1]  of
     record
     s: string  [12];
     v: word
     end=
    ((S:'Cut';           v:Cmcut),
     (s:'Copy';          v:cmcopy),
     (s:'Paste';         v:cmPaste),
     (s:'Undo';          v:cmUndo),
     (s:'Clear';         v:cmClear),
     (s:'Save';          v:cmSave),
     (s:'SaveAs';        v:cmSaveAs),
     (s:'Find';          v:cmFind),
     (s:'Replace';       v:cmReplace),
     (s:'SearchAgain';   v:cmSearchAgain),
     (s:'CharLeft';      v:cmCharLeft),
     (s:'CharRight';     v:cmCharRight),
     (s:'WordLeft';      v:cmWordLeft),
     (s:'WordRight';     v:cmWordRight),
     (s:'LineStart';     V:cmLineStart),
     (s:'LineEnd';       v:cmLineEnd),
     (s:'LineUp';        v:cmLineup),
     (s:'LineDown';      v:cmLineDown),
     (s:'PageUp';        v:cmPageUp),
     (s:'PageDown';      V:cmPageDown),
     (s:'TextStart';     v:cmTextStart),
     (s:'TextEnd';       v:cmTextEnd),
     (s:'NewLine';       v:cmNewLine),
     (s:'BackSpace';     v:cmBackSpace),
     (s:'DelChar';       V:cmDelChar),
     (s:'DelWord';       v:cmDelWord),
     (s:'DelStart';      v:cmDelStart),
     (s:'DelEnd';        v:cmDelEnd),
     (s:'DelLine';       V:cmDelLine),
     (s:'InsMode';       v:cmInsMode),
     (s:'StartSelect';   v:cmStartSelect),
     (s:'HideSelect';    v:cmHideSelect),
     (s:'IndentMode';    v:CmIndentMode));
     KVal: array [$47..$53] of word= (1,2,3,4,5,0,6,7,8,9,10,11,12);
     KName: array [0..13] of String[6]=
    ('???','Home','UP','Pgup','Minus',
   'Left','Right','Plus','End',
   'Down','Pgdn','Ins','Del',
   'PrtSrc');
  MName: array [0..3] of String [5]= ('','Shift','Ctrl','Alt');
  SName: array [$72..$77] of word=   (13,5,6,8,10,1);

 type Str2=String[2];

 function Num(b: byte): Str2;
 begin
 if b=0 then Num:='10'
 else Num:=Chr(b+$30);
 end;

 function Conv(key: word): String;
 var cc: char;
  scan,cval: byte;
 begin
 scan:=Hi(key);
 cval:=Lo(key);
 case scan of
  $00:  Conv:='';
  $01: Conv:='ESC';
  $04..$07: Conv:=MName[scan mod 2 xor 1+1]+' '+KName[scan div 2+9];
  $0E: if cval=8 then Conv:='Bksp'
   else Conv:='Ctrl Bksp';
  $0F: if cval=9 then Conv:='Tab'
   else Conv:='Shift Tab';
  $1C: if cval=13 then Conv:='Cr'
   else Conv:='Ctrl Cr';
  $10..$32: begin
     cc:=GetAltChar(scan*256);
     case cval of
      0: Conv:='Alt '+cc;
      1..$1B: Conv:='Ctrl '+Cc;
      $41..$5B,
      $61..$7B: Conv:=cc;
     end;
     end;
  $39:  Conv:='';
  $3B..$44: Conv:='F'+Num(scan-$3A);
  $47..$53: Conv:=KName[KVal[scan]];
  $54..$71: Conv:=MName[(scan-$49) div 10]+' '+'F'+Num((scan-$49) Mod 10);
  $72..$77: Conv:='Ctrl '+KName[SName[scan]];
  $84: Conv:='Ctrl Pgup';
  else Conv:='???'
 end;
 end;

 function find(key: word): integer;
 var i,j,m: integer;
  found: boolean;
 begin
 i:=-1;
 j:=top;
 found:=false;
 while (i<j-1) do
 begin
  m:=(i+j) div 2;
  if T[m].k1<key then i:=m
  else if T[m].k1>=key then j:=m
 end;
 while (j>0) and (T[j-1].k1=key) do
  Dec(j);
 find:=j
 end;

 function insert(k1,k2,cm:word): integer;
 var i: integer;
 begin
 insert:=-1;
 if k1=0 then Exit;
 insert:=-2;
 if (k1=kbEsc) and (k2=kbEsc) then Exit;
 insert:=0;
 i:=find (k1);
 if (T[i].k1=k1) and (k2=0) or
  (T[i].k2=0) then Exit;
 while (T[i].k1=k1) and (T[i].k2<k2) do
  Inc(i);
 if (T[i].k1=k1) and (T[i].k2=k2) then
  Exit;
 move(T[i],T[i+1],(top-i+1)*sizeof(T[0]));
 T[i].k1:=k1;
 T[i].k2:=k2;
 T[i].cm:=cm;
 Inc(top);
 insert:=1;
 end;

 function ReadKbd: word;
 var E: TEvent;
 begin
 repeat GetKeyEvent(E);
 until E.What<>evNothing;
 if (ShiftState and 3 <> 0) and
  (E.ScanCode in [$47..$51]) then
  E.CharCode:=#0;
 Write(Conv(E.KeyCode));
 if E.KeyCode=kbBlank then ReadKbd:=0
 else ReadKbd:=E.KeyCode;
 end;

 function EditKeyTable;
 var state,k: integer;

   f: File;
 begin
   top:=0;
   T[0].k1:=$FFFF;
   T[0].k2:=$FFFF;
   for k:=0 to N-1 do
   begin
   repeat
   write(Commands[k].s,': ');
   state:=insert(ReadKbd,ReadKbd,k);
   writeln;
   if state=0 then
   writeln('Key(s) already defined');
   until (state<0);
   if state=-2 then
   begin
   EditKeyTable:=ReadKeyTable;
   Exit;
   end;
   end;
   EditKeyTable:=True;
   Assign(f,'edit.cfg');
   Rewrite(f,1);
   blockwrite(f,top,2);
   blockwrite(f,T,top*sizeof(T[0]));
   close(f)
 end;

 function ReadKeyTable;
 var f: file;
   Result: word;
 begin
   top:=0;
   ReadKeyTable:=False;
   assign(f,'edit.cfg');
   reset(f,1);
   if IOResult<>0 then
   begin
   EditorDialog(edNoKeyTab,NiL);
   Exit
   end;
   blockread(f,top,2,Result);
   if Result<>2 then
   begin
   EditorDialog(edNoKeyTab,Nil);
   Close(f);
   Exit;
   end;
   blockread(f,T,sizeof(T[0])*top);
   cloSe(f);
   ReadKeyTable:=True;
   T[top].k1:=$FFFF;
   T[top].k2:=$FFFF
 end;

 procedure GetComm;
 begin
   if (ShiftState and 3<>0) and (E.ScanCode in [$47..$51])
     then E.CharCode:=#0;
   if Pos=0 then
   begin
   Pos:=find(E.KeyCode);
   if T[Pos].k1<>E.KeyCode then Pos:=0
   else if T[Pos].k2=0 then
   begin
   E.Command:=Commands[T[pos].cm].v;
   E.What:=evCommand;
   Pos:=0;
   end
   else E.What:=evNothing;
   end
   else
   begin
   while (T[Pos+1].k1=T[Pos].k1) and
   (T[Pos+1].k2<=E.KeyCode) do Inc(Pos);
   if T[POS].k2=E.KeyCode then
   begin
   E.What:=evCommand;
   E.Command:=Commands[T[pos].cm].v;
   end
   else E.What:=evInvalidKey;
   Pos:=0;
   end;
 end;

 procedure ShowKeyTable;
 var k: integer;
   f: text;
 begin
   Assign(f,'out.$$$');
   Rewrite(f);
   for k:=0 to top-1 do
     writeln(f,Commands[T[k].cm].s,' : ',Conv(T[k].k1),Conv(T[k].k2));
   Close(f)
 end;

 end.
