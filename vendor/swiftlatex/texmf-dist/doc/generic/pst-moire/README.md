# **README** #
# pst-moire v. 2.1 #
# 2018/11/22 #

    Source:      pst-moire.tex, pst-moire.sty, pst-moire.pro
    Authors:     Jürgen Gilg, Manuel Luque, Jean-Michel Sarlat
    Info:        Draw moire pattern with PSTricks
    License:     LPPL 1.3c

---

# Short description #

The *pst-moire* package makes it possible to very simply create 
a variety of patterns obtained either by dragging one pattern on another, 
or by rotating one on the other. Moire effects sometimes look very interesting. 
This document provides the necessary commands and divers examples.

---

# **CHANGES COMPARED TO VERSION 1.0** #

The documentation is better structured and there were added some more
explanations for each type of moiré

---

The **type=circle** gets two new keys to be more flexible:
    
    n     Number of circles
    T     Distance between two adjacent circles in mm

The key **Rmax** is therefore out of effect. The image width/height is now 
calculated by  *n x T*. 

Scaling can be done by setting the usual PSTricks key **unit=**.

---

The **type=linear** gets two new keys to be more flexible:
    
    n     Number of the lines -1
    T     Distance between the middle two adjacent lines in mm

The key **2 \* Rmax** is the height of the lines. The image width is now 
calculated by *n x T*.

---

Adding a new command **\\addtomoirelisttype** 

This is to generate customers patterns to then be used as **type=...**

---

Adding a new section: **Random moirés**

Showing the effects that occur, when randomly placed dots within a square
overlap by the actions rotation or magnification or both of them.

Adding a new command **\\psRandomDot**

---

Adding a new section: **Glass-patterns**

Adding a new command **\\psGlassPattern**

# **CHANGES COMPARED TO VERSION 2.0** #

Adding a new command **\\psRandomDotPatterns**
 

