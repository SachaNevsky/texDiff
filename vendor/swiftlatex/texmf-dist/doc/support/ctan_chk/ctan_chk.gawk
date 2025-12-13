# section no34:*/
# section no12:*/
#
# Program: ctan_chk.gawk
#
# Author:  Dave Bone
#
# License:
# This Source Code Form is subject to the terms of the GNU General Public License (version 3).
# If a copy of the MPL was not distributed with this file,
# You can obtain one at:  "https://gnu.org/licenses/gpl.html".
#
# Purpose: Implementation of some suggested CTAN guidelines that an upload project should respect.
#          Correction functions help u cleanup the droppings.
# See www.ctan.org website for  "upload guideline" document
# Read ctan_chk.pdf document describing the program with various run scenarios.
#
#
# section no:12*/
# section no14:*/
function is_file_a_directory(filename,filetype)
{
x= "file \"%s\"";
y= sprintf(x,filename);
y|getline a;
close(y);
split(a,parts);
filetype[1]= parts[2];
xx= parts[2];
str= "^directory$";
if(xx~str){
return 1;
}
return 0;
}
# section no:14*/
# section no15:*/
function is_file_an_executable(filename,filetype)
{
x= "file %s";
y= sprintf(x,filename);
y|getline a;
close(y);
split(a,parts);
filetype[1]= parts[2];
xx= parts[2];
str= "(executable|POSIX|Mach-O|ELF)$";
if(xx~str){
return 1;
}
return 0;
}
# section no:15*/
# section no17:*/
function chk_auxiliary_files(filename)
{
if(is_file_a_directory(filename)==1)
return 0;
str= "\\.(ps|gitignore|git|aux|log|bbl|bcf|blg|brf|ilg|ind|idx|glo|loa|lof|lot|nav|out|snm|vrb|toc|dvi|glg|gls|tmp|o|bak|mpx|scn|toc)$";
if(filename~str){
a= "\"%s\" 'Auxilary file to be deleted'";
b= sprintf(a,filename);
print b;
#delete_file(filename);
return 1;
}
return 0;
}
# section no:17*/
# section no25:*/
function remove_file_s_extended_attributes(filename,message)
{
x= "echo %s\";xattr -c %s";
y= sprintf(x,message,filename);
print y;
#y|getline a;
#close(y);
}
# section no:25*/
# section no21:*/
function chk_file_permissions(filename)
{
filetype[1]= "";
if(is_file_a_directory(filename,filetype)==1)
return 0;
if(is_file_an_executable(filename,filetype)==1)
return 0;
x= "ls -al \"%s\"";
y= sprintf(x,filename);
y|getline a;
close(y);
number_fields= split(a,parts);
str= "x";
if(parts[1]~str){
a= "\"%s\" 'Write permissions %s to possibly delete file type: %s'";
b= sprintf(a,filename,parts[1],filetype[1]);
print b;
return 1;
}
return 0;
}
# section no:21*/
# section no18:*/
function chk_extended_file_attributes(filename)
{
x= "ls -al \"%s\"";
y= sprintf(x,filename);
y|getline a;
close(y);
number_of_fields= split(a,parts);
if(number_of_fields<9)
return 0;
xx= parts[1];
str= "(@|+)$";
if(xx!~str){
return 0;
}
a= "\"%s\" 'Extended attributes %s'";
b= sprintf(a,filename,parts[1]);
print b;
#remove_file_s_extended_attributes(filename,b);
return 1;
}
# section no:18*/
# section no19:*/
function chk_empty_files(filename)
{
if(is_file_a_directory(filename)==1)
return 0;
x= "ls -al \"%s\"";
y= sprintf(x,filename);
y|getline a;
close(y);
number_of_fields= split(a,parts);
if(number_of_fields<9)
{
print"ERROR ===> ls -al should be 9 fields and it isn't: "a" no fields: "number_of_fields;
return 0;
}
i= strtonum(parts[5]);
if(i> 0){
return 0;
}
a= "\"%s\" 'Empty file to be deleted'";
b= sprintf(a,filename);
print b;
#delete_file(filename);
return 1;
}
# section no:19*/
# section no20:*/
function chk_empty_directory(filename)
{
if(is_file_a_directory(filename)==0)
return 0;
x= "du -sk \"%s\"";
y= sprintf(x,filename);
y|getline a;
close(y);
number_of_fields= split(a,parts);
i= strtonum(parts[1]);
if(i> 0)
return 0;
a= "\"%s\" 'Empty directory to be deleted or needs to add info.txt file inside it'";
b= sprintf(a,filename);
print b;
return 1;
}
# section no:20*/
# section no26:*/
function delete_file(filename)
{
x= "rm -i \"%s\"";
y= sprintf(x,filename);
y|getline a;
close(y);
}
# section no:26*/
# section no22:*/
function chk_file_to_bypass_in_zip(filename)
{
str= ".(DS_Store|.nbattrs)$";
if(filename~str){
a= "\"%s\" 'Bypass file in zip'";
b= sprintf(a,filename);
print b;
return 1;
}
return 0;
}
# section no:22*/
# section no28:*/
function pass1_guidelines_verify(filename)
{
chk_auxiliary_files(filename);
chk_extended_file_attributes(filename);
chk_empty_files(filename);
chk_empty_directory(filename);
chk_file_permissions(filename);
chk_file_to_bypass_in_zip(filename);
}
# section no:28*/
# section no29:*/
function pass2_correct(filename,message)
{
#remove_file_s_execute_attribute(filename,message);
#remove_file_s_extended_attributes(filename,message);
#delete_file(filename);
}
# section no:29*/
# section no31:*/
BEGIN{
rec_cnt= 0;
}
# section no:31*/
# section no32:*/
{
pass1_guidelines_verify($1);
#pass2_correct($1,$2);
}
# section no:32*/
# section no33:*/
END{
#print "no records read: " NR;
}
# section no:33*/
# section no:34*/
