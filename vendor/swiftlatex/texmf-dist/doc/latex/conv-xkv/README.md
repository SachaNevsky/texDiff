The conv-xkv Package
Author: D. P. Story
Dated: 2017-02-17

This small package supports key-value syntax other than the standard latex 
syntax of <key>=<value>. Using this package, create key-values of the form 
<key>:<value> or <key>-><value>, for example. The package converts the new 
notation to xkeyval notation and passes it on to xkeyval. 

What's new: (2017/01/03) The delimiters for the optional first argument
of \cxkvsetkeys is changed from the standard `[]' to `()'. Also, if no key-value
of the special type (such as <key>:<value> or <key>-><value>) is detected, the 
whole argument is passed to \setkeys. This means that either the new key-value
pairing or the standard pairing may be used; \cxkvsetkeys{lname:Story} or
\cxkvsetkey{lname=Story} both work.

Please test and give feedback.

Enjoy.

D. P. Story
www.acrotex.net
dpstory@uakron.edu
dpstory@acrotex.net


