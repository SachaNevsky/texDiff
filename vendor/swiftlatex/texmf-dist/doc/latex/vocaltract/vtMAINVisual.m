function vtMAINVisual(VocalTractVecToTime,SWPDForBMP)

if nargin < 2
  SWPDForBMP = 'BMP';       % PDF, BMP
  %========================================================================================
  % 1. Jaw Position     4. Tongue Apex     7. Larynx Height       10. Nasal Cavity
  %  2. Tongue Position  5. Lip Aperture    8. Glottal Aperture    11. Phoneme Label 
  %   3. Tongue Shape     6. Lip Protrusion  9. Glottal Frequency  
  %========================================================================================
  %  1       2     3       4      5      6     7    8     9    10      11
  % JW      TP    TS      TA     LA     LP    LH   GA    FX    NS 
  %  3       3     3       3      3      3     3    3     3     3                Max 
  %  0       0     0       0      0      0     0    0     0     0                Relax
  % -3       3    -3      -3     -3     -3    -3   -3    -3    -3                Min
  %========================================================================================
  VocalTractVecToTime = ...                           
   {[ 0.5, -2,    1 ,     -2 ,    1,    -1  ,  0,   0,    0,    0],   'i'      ;   
    [ 0.5, -2,    1 ,     -2 ,    0,     2  ,  0,   0,    0,    0],   'y(\"u)' ; 
    [-1  , -1,    1 ,     -2 ,    1,    -0.5,  0,   0,    0,    0],   'e'      };
end

% if you want a BMP Figure (not a PDF Animation) use first line 
if strcmp(SWPDForBMP,'BMP') && size(VocalTractVecToTime,1)>1  
   VocalTractVecToTime = VocalTractVecToTime(1,1:2);
end


NumberOfTimeFrames     = size(VocalTractVecToTime,1);
VocalTractVecToTimeSTR = Mat2StrCustom(VocalTractVecToTime);

%---------------- Add some commands before and after ---------------
LatexDefCommandsOfCordsPre = ['\newarray\SpeakVec' ...
                              '\readarray{SpeakVec}{'];
                        
LatexDefCommandsOfCordsPost = ['}'...
                               ' \dataheight=11' ...
                ' \def\Nframes{' num2str(NumberOfTimeFrames+1) '}'];
 
% %------- Create the Coordinates file ----------------              
fid = fopen('vtLatex_TimeParams.tex', 'w');
                                    
fwrite(fid,sprintf('%s %s %s',LatexDefCommandsOfCordsPre,...
              VocalTractVecToTimeSTR,...
             LatexDefCommandsOfCordsPost),'char');                          
fclose(fid);

%---------------- START the Compilers -----------------------------

if strcmp(SWPDForBMP,'BMP')
  %-- tex2dvi
  !latex -interaction=nonstopmode vtLatex_FigureLauncher.tex
  %--- view dvi 
  %!"C:/Program Files/MiKTeX 2.8/miktex/bin/yap.exe" vtLatex_FigureLauncher.dvi
  %--- dvi2ps 
  !dvips -o vtLatex_FigureLauncher.ps vtLatex_FigureLauncher.dvi
    
  %--- ps2bmp
  strpwd = lower(pwd);
  eval(['!i_view32.exe "' strpwd '\vtLatex_FigureLauncher.ps"' ...
    ' /crop=(130,250,550,600)  /convert="' ...
                           strpwd '\vtLatex_FigureLauncher.bmp" ']);
  
  %--- read and show
  a = imread('vtLatex_FigureLauncher.bmp');
  imshow(a);
elseif strcmp(SWPDForBMP,'PDF')
  %-- tex2dvi
  !latex -interaction=nonstopmode vtLatex_AnimationLauncher.tex
  %--- view dvi 
  %!"C:/Program Files/MiKTeX 2.8/miktex/bin/yap.exe" vtLatex_AnimationLauncher.dvi
  %--- dvi2ps 
  !dvips -o vtLatex_AnimationLauncher.ps vtLatex_AnimationLauncher.dvi  
  %---- ps2pdf
  !ps2pdf vtLatex_AnimationLauncher.ps
  %--- view pdf
  !AcroRd32.exe vtLatex_AnimationLauncher.pdf
end




%===================================================================
%          Matrix to a String Ordering with & intervening
%===================================================================
function STR = Mat2StrCustom(Matr)

R = size(Matr,1);
C = length(Matr{1,1});

STR = [];
for IndRow= 1:R
    for IndCol = 1:C
        STR = [STR num2str(Matr{IndRow,1}(IndCol)) '&'];
    end
    STR = [STR Matr{IndRow,2} '&'];
end
STR = STR(1:end-1);


