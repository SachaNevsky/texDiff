<!DOCTYPE style-sheet PUBLIC "-//James Clark//DTD DSSSL Style-Sheet//EN">
<style-sheet>
<style-specification>
<style-specification-body>

(define FontSize 12pt)

(root
  (make simple-page-sequence
    left-margin:  2cm
    page-width:   15cm
    right-margin: 2cm
    (make scroll
      font-size: FontSize
      (process-children))))

(element front
  (make sequence
    (make paragraph
      quadding:    'center
      space-before:   20pt
      font-weight: 'bold
      font-size:   24pt
      (literal "INVITATION")) 
    (make table
      table-border:   #f  ; no border
      display-alignment: 'start
      space-before:   20pt
      (make table-part
        (make table-column width: 25mm)
        (make table-column width: 10cm)
        (process-children)))))
(element (front date)
  (make table-row
    (make table-cell
      (make paragraph quadding: 'start
        (literal "When:")))
    (make table-cell
        (process-children))))
(element (front to)
  (make table-row
    (make table-cell
     (make paragraph quadding: 'start
        (literal "To:")))
    (make table-cell
        (process-children))))
(element (front where)
  (make table-row
    (make table-cell
      (make paragraph quadding: 'start
        (literal "Venue:")))
    (make table-cell
        (process-children))))
(element (front why)
  (make table-row
    (make table-cell
      (make paragraph quadding: 'start
        (literal "Occasion:")))
    (make table-cell
        (process-children))))

(element (body par)
  (make paragraph
    quadding: 'justify
    font-size: FontSize
    space-before: FontSize
    (process-children)))
(element emph
  (make sequence
    font-posture: 'italic
    (process-children)))

(element (back signature)
  (make paragraph
    quadding: 'end
    space-before: FontSize
    (literal "From: ")
    (process-children)))

</style-specification-body>
</style-specification>
</style-sheet>
