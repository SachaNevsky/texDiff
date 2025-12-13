USES Dos,Crt;
VAR Lw: Char;

FUNCTION Checkdrive(Drive : Byte): Boolean;
  VAR Regs: Registers;
    Anz_Floppy,A_Or_B: Byte;

  BEGIN
    Anz_Floppy:=((Mem[$40:$10] And 192) Shr 6)+1;
    A_Or_B:=Mem[$50:$04];
    If ((Drive=1) And (Anz_Floppy=1) And (A_Or_B=00))
    Or ((Drive=0) And (Anz_Floppy=1) And (A_Or_B=01)) Then
    BEGIN
      Checkdrive:=False;
      Exit;
    END;
    Checkdrive:=Not(Disksize(Drive+1)=-1);
  END;

BEGIN
  REPEAT
    BEGIN
      Lw:=Readkey;
      Lw:=Upcase(Lw);
      If Not Checkdrive(Ord(Lw)-65) Then
      Writeln('Laufwerk ',Lw,' nicht vorhanden')
      Else Writeln('Laufwerk ',Lw,' vorhanden');
    END;
  UNTIL Lw=#13;
END.
