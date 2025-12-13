The grayhints Package
Author: D. P. Story
Dated: 2018-11-01

This package provides JavaScript code snippets to create 'gray hints'. Gray 
hints, as I term them, are text that appears initially in a text field that 
gives a short hint as to what the contents of the text field should be; for 
example, a text field might contain the hint 'First Name', or a date field 
might read 'yyyy/mm/dd'. As soon as the field comes into focus, the hint 
disappears. It reappears when the field is blurred and the user did not enter 
any text into the field.

What's New (2018/11/01) Revised package to work correctly with PDF-XChange Editor (not
PDF-XChange View). Improved code for handling the case where the user commits date by 
pressing the Enter key (the data is committed, but the field does not blur). Some commands
for customizing the user experience in the case of pressing the Enter key to commit.

Dependent packages: 
    (1) eforms (2017/02/27) to use the field fields of eforms.
    (2) insdljs (2017/03/02) a minimal requirement when using form fields defined
        by hyperref when calculation fields are used.
    (3) Hyperref form fields may be used without eforms or insdljs, but the gray
        hints for calculation fields will not appear. 

Package works for dvips/Distiller, pdflatex, lualatex, and xelatex.

PDF Viewers: Adobe Reader DC, PDF-XChange Editor, and, of course Adobe Acrobat.
     
Enjoy!

Now, I must get back to my retirement.

dps
dpstory at uakron dot edu
