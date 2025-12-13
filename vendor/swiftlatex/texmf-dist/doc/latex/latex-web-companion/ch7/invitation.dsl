<!DOCTYPE style-sheet PUBLIC "-//James Clark//DTD DSSSL Style-Sheet//EN">
<style-sheet>
<style-specification>
<style-specification-body>
(define FontSize 12pt)
(root
  (make simple-page-sequence
    left-margin:  25mm
    page-width:   205mm
    right-margin: 25mm
    (make scroll
      font-size: FontSize
      line-spacing: FontSize
      (process-children)
    )
  )
)
(element (front date)
  (make paragraph
    (literal "When: ")
    (process-children)
  )
)
(element (front to)
  (make paragraph
    (literal "To: ")
    (process-children)
  )
)
(element (front where)
  (make paragraph
    (literal "Venue: ")
    (process-children)
  )
)
(element (front why)
  (make paragraph
    (literal "Occasion: ")
    (process-children)
  )
)
(element (body par)
  (make paragraph
    quadding: 'justify
    font-size: FontSize
    space-before: FontSize
    (process-children)
  )
)
(element emph
  (make sequence
    font-posture:   'italic
    (process-children)
  )
)
(element (back signature)
  (make paragraph
    quadding: 'justify
    space-before: FontSize
    (literal "From: ")
    (process-children)
  )
)
</style-specification-body>
</style-specification>
</style-sheet>
