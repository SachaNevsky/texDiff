<!DOCTYPE style-sheet PUBLIC "-//James Clark//DTD DSSSL Style-Sheet//EN">
<style-sheet>
<style-specification>
<style-specification-body>
(define FontSize 12pt)
(root
  (make simple-page-sequence
    left-margin:  1cm
    page-width:   10cm
    right-margin: 1cm
    (make scroll
      font-size: FontSize
      (process-children))))
(element invitation
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
        (make table-row
          (make table-cell
            (make paragraph quadding: 'start
              (literal "When:")))
          (make table-cell
            (make paragraph quadding: 'start
              (literal (attribute-string "date")))))
        (make table-row
          (make table-cell
            (make paragraph quadding: 'start
              (literal "To:")))
          (make table-cell
            (make paragraph quadding: 'start
              (literal (attribute-string "to")))))
        (make table-row
          (make table-cell
            (make paragraph quadding: 'start
              (literal "Venue:")))
          (make table-cell
            (make paragraph quadding: 'start
              (literal (attribute-string "where")))))
        (make table-row
          (make table-cell
            (make paragraph quadding: 'start
              (literal "Occasion:")))
          (make table-cell
            (make paragraph quadding: 'start
              (literal (attribute-string "why")))))))
    (process-children)
    (make paragraph
      quadding: 'end
      space-before: FontSize
      (literal "From: "
        (attribute-string "signature")))))
(element par
  (make paragraph
    quadding: 'justify
    font-size: FontSize
    space-before: FontSize
    (process-children-trim)))
(element emph
  (make sequence
    font-posture: 'italic
    (process-children-trim)))
</style-specification-body>
</style-specification>
</style-sheet>
