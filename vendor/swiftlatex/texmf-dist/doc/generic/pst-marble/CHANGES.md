# **CHANGES** #
# pst-marble v. 1.6 #
# 2019/05/10 #

    Source:      pst-marble.tex, pst-marble.sty, pst-marble.pro
    Author:      Aubrey Jaffer
    Maintainers: Jürgen Gilg, Manuel Luque
    Info:        Draw marble-like pattern with PSTricks
    License:     LPPL 1.3c

---
    
## Changes in v. 1.0: 

## Complete reorganization of the basic deformation commands 

We reorganized the marbling primitives to have consistent units
which model a 1 m by 1 m region of a much larger tank. All lengths are
in mm, velocities (in mm/s), angles (in degrees), angular velocity (in
degrees/s), and viscosity and circulation (in mm^2/s).

For a convex stylus or tine, **D** (in mm) is the ratio of its submerged
volume to its wetted surface area. For a long cylinder it is diameter.

The deformations take a single argument, **viscosity** (in mm^2/s), which is also
viscosity relative to 20 °C water. Negative viscosity specifies
(raster) reverse-marbling.

## /drop 

**\[ cx cy radinc \[ bgc \] \[ rgb \] /drop \]**

Replaces **/ink**; works as before.

## /offset ##

**\[ dx dy /offset \]**

As before.  Maybe should be changed to take angle and length.

## /stir 

**\[ cx cy \[ r \] w th D /stir \]**

replaces **/circle**.  Tines follow concentric circular tracks.

    cx, cy   Center coordinates in mm
    [ r ]    List of radii in mm
    w        Angular velocity
    th       Displacement at tines
    D        Tine diameter

## /vortex 

**\[ cx cy circ t /vortex \]**

Models a **Lamb-Oseen** vortex.

    cx, cy   Center coordinates in mm
    circ     Circulation (in mm^2/s) is a simple scale factor. 
    Typical value: 30e3 mm^2/s.
    t        Time after circulation impulse at center.  As t gets very large, 
    the whole surface returns to its original pattern, possibly with rigid 
    rotation. Typical value 10 s.

## /stroke 

**\[ bx by ex ey V D /stroke \]**

As before; short stroke.

    bx, by   Beginning of stroke    
    ex, ey   End of stroke
    V        Stylus velocity in mm/s
    D        Stylus diameter in mm.  Make larger to affect paint farther away.

## /rake 

**\[ angle \[ r \] V tU D /rake \]**

replaces **/line**.  Draws a stylus or parallel stylii across the tank.

    angle   Angle from y-axis in degrees; 0 is up.
    [ r ]   List of distances from center of image (0,0).
    V       Stylus velocity in mm/s
    tU      Distance points on the stylus track are moved.
    D       Stylus diameter in mm.  Make larger to affect paint farther away.

## /wiggle 

**\[ angle {func} /wiggle \]**

Parameters changed.

    angle    Wiggle will be perpendicular to angle from y-axis up.
    {func}   Input is distance in mm; output is wiggle displacement in mm.
    
## NEW ACTIONS

## random-drops

**\[ size \[ color \] count random-drops \]**

    count     Number of the drops
    size      Size of the drops
    color     Color of the drops

## random-drops-colors

**\[ size  count random-drops-colors \]**

    count     Number of the drops
    size      Size of the drops

## concentric-bands

**\[ cx  cy RadiusIncrement NumberOfBands  concentric-bands \]**

    cx, cy             Center coordinates
    RadiusIncrement    Multiplication coefficient between the bands
    NumberOfBands      Number of the elements within
                       the [array of colors] list
                       [array of colors]: this is the list of colors
                                          within the colors= key


## ADDITIONAL HINTS

Having stylus diameter, velocity, and viscosity as parameters means
this system has an extra degree of freedom. If you want to reduce the
width of the affected region of a rake by a factor of 10, either
reduce **V** by a factor of 10 or reduce **D** by a factor of 3.1 (sqrt 10).

---

## Changes in v. 1.1:

## Customer friendly setup of the actions. 

No \[ ... \] around the actions needed anymore. And no  **/** for the actions.

## NEW ACTIONS

## arc-drops 

**xc yc r ang-strt ang-step \[rgb\] cnt drad arc-drops**

    cnt       Number of drops
    drad      Radius of the drops
    rgb       Color of the drop series
    xc,yc     Center coordinates of the arc
    r         Radius of the arc
    ang-strt  Starting angle

## spiral-drops
 
**xc yc r ang-strt ang-step rinc \[rgb\] cnt drad spiral-drops**

    Like arc-drops, but increments (or decrements if negative) r by rinc
    after each drop

## concentric-bands is now obsolete

To be setup now with: **concentric-rings**

under more customer friendly conditions - see documentation


## rake

For the **rake** action there is the possibility to setup the rakes with
the PostScript command *tines*

## tines

**cnt spacing ofst tines**

    cnt       Number of rakes
    spacing   displacement between the rakes
    ofst      offset of the middle rake 
              to the left (negative), 
              to the right (positive)

## background

The **background** option now can use the color schemes **rgb** and **RGB**

With **rgb** we use decimals between 0 and 1

With **RGB** we use integers between 0 and 255

The colors then are automatically detected correctly.

## rgb and RGB color schemes

They are available for these following actions as well:

    drop
    arc-drops
    spiral-drops

and automatically detected.

---

## Changes in v. 1.2:

The actions **arc-drops** and **spiral-drops** are erased and bundled together
under the action: 

## **coil-drops**

**xc yc r ang-strt arcinc rinc \[ rgb \] cnt drad coil-drops**

    xc, yc    Coordinates of the center
    r         Radius of the circle where the drops will lay on
    ang-str   Start angle from vertical: if 0 it starts North, 
        if 90 it starts East, ...
    arcinc    Arc-distance between the drops
    rinc      Increment of r: 
        if taken 0 it gives a circle,
        if taken >0 it spirals outwards,
        if taken <0 it spirals inwards.
    rgb       Color of the drops or color series
    cnt       Number of the drops
    drad      Radius of the drops

The actions **random-drops** and **random-drops-colors** are erased and substituted
by *two new fully parameterized actions*:

## **Gaussian-drops**

Defines a randomly calculated series of drops within a circle/ellipse

**xc yc r ang eccentricity \[ rgb \] cnt drad Gaussian-drops**

Drops **cnt** paint drops with radius **drad** in normal (Gaussian) distribution 
centered at **xc, yc** with radius **r**, **ang** degrees from vertical and 
length to width ratio **eccentricity** (1 is circular). 

## **uniform-drops** 

Defines a randomly calculated series of drops within a rectangled box 

**xc yc xsid ysid angle \[ rgb \] cnt drad uniform-drops**

Drops **cnt** paint drops with radius **drad** in a uniform distribution in a 
**xsid** by **ysid** box centered at **xc, yc** and rotated by **angle**.

## **wiggle**  is made more customer friendly:

**angle period ofst depth wiggle**

Applies sinsusoidal wiggle: y = depth sin(360 x/period + ofst)

    angle     Wiggle will be perpendicular to angle from y-axis up.
    period    Period of the sinusoidal wiggle (in degrees)
    depth     Amplitude of the sinusoidal wiggle
    ofst      Displacement of the sinusoidal wiggle

## **background** option

This color option for the background is now to typeset like:

**background=\{\[rgb\]\}** or **background=\{\[RGB\]\}**

to be consistent to all other color settings


## rgb and RGB color schemes

They are available for these following actions as well:

    drop
    the 4 -drops actions
    
## Colors

The colors now set up: 

**\[rgb/RGB\]** 

or as a series of colors (an array)

One can use as well hexadecimal color constants, like

**(e7cc9b)** or with capital letters **(E7CC9B)**

which are setup in parentheses and not square brackets.

**\[\[rgb/RGB\] \[rgb/RGB\] \[rgb/RGB\] \[rgb/RGB\] ...\]**

## New option **seed**

This is set to *Mathematical Marbling* by default to keep the drops to their 
initial randomly chosen places. 
Made for **Gaussian-drops** and **uniform-drops**.

---

## Changes in v. 1.3: 

## **stroke** action 

now becomes **stylus** action, however **stroke** still can be used.

## Rotations 

now are consistent. From vertical clockwise

## New action **serpentine-drops**

**serpentine-drops** deposits a series of drops on a user-specified *grid* 
in a serpentine sequence.

## New option **oversample**

This option pixels the image. If taken *oversample=0* we get no-pixeled images.
If taken *oversample=1* we get the same as with *viscosity= negative* (v1.2) 
which now is obsolete, but still works. 
The smaller the *oversample* value is taken (between 0<*oversample*<1) the more
blocky the image gets rastered.

## Transparency and Blendmodes

A patch from **A. Grahn** now makes it possible to use these options the 
*normal* PSTricks way and needn't be introduced within the **actions=\{...\}**
with raw PostScript code. Equal now for ps2pdf, xelatex and distiller.

## Bug fixes

---

## Changes in v. 1.3a: 

## Bug fixes

---

## Changes in v. 1.4:

## The command **\\psMarble** 

is now available in two forms:

**\psMarble\[parameter-assignment,...,parameter-assignment\](width,height)**

**\psMarble\[parameter-assignment,...,parameter-assignment\](x−,y−)(x+,y+)** 

## New option **overscan**

When the overscan value is greater than 1, proportionally more image 
(outside of the specified area) is shown, and the specified area is outlined 
with a dashed rectangular border.

## New option **spractions** with new post-marble actions

Specifies the sequence of spray commands to perform. 
Spray commands are performed after marbling.

## **Gaussian-spray**

**xc yc r ang eccentricity \[ rgb \] n Rd Gaussian-spray**

Places **n** drops of colors **\[rgb\]** randomly in a circular 
or elliptical disk centered at **xc, yc** having mean radius **Rd**, 
**ang** degrees clockwise from vertical, and length-to-width ratio 
**eccentricity**.

## **uniform-spray** 

**xc yc xsid ysid angle \[ rgb \] n Rd uniform-spray**

Places **n** drops of colors **\[rgb\]** randomly in a **xsid** by **ysid** 
rectangle centered at location **xc, yc** and rotated by **ang** degrees 
clockwise from vertical.

---

## Changes in v. 1.5:

## New option **shadings** with post-marble actions

Specifies the sequence of shading commands to perform when
*oversample>0*.  Shading commands are performed after marbling and
spraying.

## **normal-drops** and **normal-spray**

**xc yc Lprp Lprl ang \[ rgb \] n Rd normal-drops**
**xc yc Lprp Lprl ang \[ rgb \] n Rd normal-spray**

Replace **Gaussian-drops** and **Gaussian-spray** commands.  Have same
arguments and order of arguments as **uniform-drops** and
**uniform-spray**.

## **jiggle** 

**angle period ofst depth pdepth jiggle**

Replaces **wiggle** with more power: supports both variation in angle
direction *depth* and perpendicular to angle direction *pdepth*.
**wiggle** had only perpendicular variation.

## **shade**

**rgb gamma shade**

Raises each component of *rgb* to the *gamma* power.  *gamma* between
0 and 1 darkens  *rgb*; *gamma* between 1 and 2 lightens *rgb*.

---

## Changes in v. 1.6:

## New option **paper**

Specifies the paper color for **shadings** commands.

## **tint**

**rgb gamma tint**

Raises each component of *rgb* to the 2-*gamma* power.  *gamma*
between 0 and 1 darkens *rgb*; *gamma* between 1 and 2 lightens *rgb*.

**shading** renamed **jiggle-shade**.

**rgb zeta edgy-color**

Added command which:
Returns the rgb color flagged so that in raster rendering the
boundary of each drop of that color is lightened while its center is
darkened.

**x y lambda A B wriggle**
**x y lambda Omega A_s wriggle-shade**

Added commands which are polar-coordinate analogues to **jiggle** and
**jiggle-shade**.

**x y theta turn**

Turns tank around **x,y** by **theta** degrees clockwise.
