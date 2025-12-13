function vtQueryVisual(STRQuery)

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
VocalTractVecToTimeCodeBook = ...                           
   {[ 0.5, -2  , 1    ,-2     , 1  , -1   , 0  ,  0,    0,    0],   'i'       ; % 1   
    [ 0.5, -2  , 1    ,-2     , 0  ,  2   , 0  ,  0,    0,    0],   'y'       ; % 2 (\"u)
    [-1  , -1  , 1    ,-2     , 1  ,-0.5  , 0  ,  0,    0,    0],   'e'       ; % 3
    [-1  , -1  , 1    ,-2     , 0  ,  2   , 0  ,  0,    0  , 0  ],  '2'       ; % 4 (\"o)
    [-1.5,  2.5, 0    ,-0.5   , 0  ,  2   , 0  ,  0,    0  , 0  ],  'E'       ; % 5 (\"a)
    [-1.5,  1.5, 0    , 0.5   , 0.5, -0.5 , 0  ,  0,    0  , 0  ],  '@'       ; % 6 (Schwa)
    [-1.5,  2.5, 0    ,-0.5   , 0.5, -0.5 , 0  ,  0,    0  , 0  ],   'a'      ; % 7
    [0.5 ,  2  , 1.5  ,-2     ,-1  ,  1.5 , 0  ,  0,    0  , 0  ],   'u'      ; % 8 
    [-0.4,  3.0, 1.5  , 0     ,-0.3,  0   , 0  ,  0,    0  , 0  ],   'o'      ; % 9  
... %-------------------------------------------------------------------Unvoiced Cons.--------
    [0   ,  0   , 0   ,  0    ,-3  ,  0   , 0  ,-3  , -3  , -3 ],   'p'       ; % 10 % UPlosives
    [0   , -0.5 ,-1   ,  2.3  , 0  ,  0   , 0  ,-3  , -3  , -3 ],   't'       ; % 11
    [0   , -1.5 , 3   , -3    , 0  ,  0   , 0  ,-3  , -3  , -3 ],   'k'       ; % 12
    [2   ,  1   , 0   ,  0    ,-1.5, -2   , 0  ,-3  , -3  , -3 ],   'f'       ; % 13 % UFricatives
    [2.5 ,  0   , 0   ,  0.4  , 0  ,  0   , 0  ,-3  , -3  , -3 ],   's'       ; % 14
    [0   , -1   , 3   , -3    , 0  ,  0   , 0  ,-3  , -3  , -3 ],   'x'       ; % 15
...%----------------------------------------------------------------- Voiced Cons. --------
    [0   ,  0   , 0   ,  0    ,-3  ,  0   ,-1  , -1 ,  0  , -3 ],   'b'       ; % 16 % VPlosives 
    [0   , -0.5 ,-1   ,  2.3  , 0  ,  0   , 0  , -1 ,  0  , -3 ],   'd'       ; % 17
    [0   , -1.5 , 3   , -3    , 0  ,  0   , 0  , -1 ,  0  , -3 ],   'g'       ; % 18
    [1   ,  0   , 0   ,  3    , 0  ,  0   , 0  , -1 ,  0  ,  0 ],   'r'       ; % 19 % Rolled
    [0   , -2   , 3   ,  3    , 0  ,  0   , 0  , -1 ,  0  ,  0 ],   'l'       ; % 20 % Lateral
    [0   ,  2.3 , 2.5 , -2    , 0  ,  0   , 0  , -1 ,  0  ,  0 ],   'R'       ; % 21 % Approximants
    [1   ,  0   , 2   ,  0    , 0  ,  0   , 0  , -1 ,  0  ,  0 ],   'j'       ; % 22
    [2   ,  1   , 0   ,  0    ,-1.5, -2   , 0  , -1 ,  0  ,  0 ],   'v'       ; % 23 % VFricatives
    [2.5 ,  0   , 0   ,  0.4  , 0  ,  0   , 0  , -1 ,  0  ,  0 ],   'z'       ; % 24
    [0   ,  0   , 0   ,  0    ,-3  , -1   , 0  , -1 ,  0  ,  0 ],   'm'       ; % 25 % Nasals   
    [0.5 ,  0   , 0   ,  3    , 0  ,  0   , 0  , -1 ,  0  ,  0 ],   'n'       }; % 26 



VocalTractVecToTime = FindVectorsFromCodeBook(VocalTractVecToTimeCodeBook, STRQuery);

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
  %-- tex2dvi
  !latex -interaction=nonstopmode vtLatex_AnimationLauncher.tex
  %--- dvi2ps 
  !dvips -o vtLatex_AnimationLauncher.ps vtLatex_AnimationLauncher.dvi  
  %---- ps2pdf
  !ps2pdf vtLatex_AnimationLauncher.ps
  %--- view pdf
  !AcroRd32 vtLatex_AnimationLauncher.pdf


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
%STR = STR(1:end-1);

%===================================================================
%                       QUERY CODEBOOK
%===================================================================
function OutVecs = FindVectorsFromCodeBook(InVecs, STRQuery)

NPhonemes = length(STRQuery);

NumericBookPhonemes = zeros(1,NPhonemes);

BookOfPhonemes = InVecs(:,2);

for iPhoneme = 1:NPhonemes, 
    NumericBookPhonemes(iPhoneme) = find(strcmp(BookOfPhonemes,STRQuery(iPhoneme)));
end

OutVecs = InVecs(NumericBookPhonemes,:);    
return     



