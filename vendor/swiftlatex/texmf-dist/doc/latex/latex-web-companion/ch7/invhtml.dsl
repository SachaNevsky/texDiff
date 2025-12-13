<!DOCTYPE style-sheet PUBLIC "-//James Clark//DTD DSSSL Style-Sheet//EN">
<style-sheet>
<style-specification>
<style-specification-body>
(declare-flow-object-class element
  "UNREGISTERED::James Clark//Flow Object Class::element")
(declare-flow-object-class empty-element
  "UNREGISTERED::James Clark//Flow Object Class::empty-element")
(declare-flow-object-class document-type
  "UNREGISTERED::James Clark//Flow Object Class::document-type")

(define FontSize 12pt)
(root
  (make simple-page-sequence
    left-margin:  25mm
    page-width:   205mm
    right-margin: 25mm
    (make sequence
      font-size: FontSize
      line-spacing: FontSize
      (make document-type 
        name: "HTML" 
        public-id: "-//W3C//DTD HTML 3.2//EN")
      (make element gi: "HEAD"
        (make element  gi: "TITLE"
          (literal "Invitation (XML to HTML transformation)"))
        (make empty-element  gi: "LINK"
                       attributes: (list (list "href" "invit.css")
                                         (list "rel"  "stylesheet")
                                         (list "type" "text/css"))))
      (make element gi: "BODY"
        (make sequence
          (make element gi: "H1"
            (literal "INVITATION"))
          (process-children))))))

(element (front)
  (make element gi: "TABLE"
                attributes: (list (list "border" "5")
                                  (list "frame"  "hsides")
                                  (list "rules"  "none")
                                  (list "width"  "100%"))
    (process-children)))
(element (front date)
  (make element gi: "TR"
    (make sequence
      (make element gi: "TD"
                    attributes: (list (list "class" "front"))
        (literal "When: "))
      (make element gi: "TD"
        (process-children)))))
(element (front to)
  (make element gi: "TR"
    (make sequence
      (make element gi: "TD"
                    attributes: (list (list "class" "front"))
        (literal "To: "))
      (make element gi: "TD"
        (process-children)))))
(element (front where)
  (make element gi: "TR"
    (make sequence
      (make element gi: "TD"
                    attributes: (list (list "class" "front"))
        (literal "Venue: "))
      (make element gi: "TD"
        (process-children)))))
(element (front why)
  (make element gi: "TR"
    (make sequence
      (make element gi: "TD"
                    attributes: (list (list "class" "front"))
        (literal "Occasion: "))
      (make element gi: "TD"
        (process-children)))))
(element (body par)
  (make element gi: "P"
    (process-children)))
(element emph
  (make element gi: "EM"
    (process-children)))
(element (back signature)
  (make element gi: "P"
                attributes: (list (list "class" "signature"))
    (make sequence
      (literal "From: ")
        (process-children))))
</style-specification-body>
</style-specification>
</style-sheet>
