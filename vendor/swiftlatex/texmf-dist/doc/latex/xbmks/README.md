The xbmks Package
Author: D. P. Story 
Dated: 2020-01-16

Short description: Create a cross-document bookmark tree. 

The package defines the concept of a document bundle, which is a collection 
of documents that are to be build separately, but have a common bookmark 
tree. 

This package takes the bookmarks of each file in doc bundle and merges them. 
The merged bookmarks are listed in all the documents of the document bundle. 
In this way, a sort of 'table of contents' is available to all documents in 
the bundle.

PDF Creator: no restrictions, use dvips->distiller|ps2pdf, pdflatex, 
lualatex, or xelatex.

What's New (2020/01/16) Minor modifications to conform to the 
new web.cfg, which is read, if it exists. 

What's New (2018/07/04) Fixed a problem wherein the bookmarks do not appear
after an even number of compilations.

What's New (2018/06/25) Defined new commands for creating bookmarks for which 
arbitrary actions, color and style can be applied. These commands build on 
hyperref's bookmark commands. 
 
What's New (2018/06/13) Corrected a misspelling in the driver specification 
for pdfmark. Now allow the docbundle key to be empty or missing; in this 
case, we set docbundle=\jobname. Bookmarks are generated for that document 
alone, as an extra benefit, the keys colors and style are still obeyed.  
 

Now, I simply must get back to my retirement.

D. P. Story
www.acrotex.net
dpstory@uakron.edu
dpstory@acrotex.net
