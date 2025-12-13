;;; listings-ext.el --- AUCTeX style for `listings-ext.sty'

;; Copyright (C) 2008-2010 Free Software Foundation, Inc.

;; Maintainer: Jobst Hoffmann, <j.hoffmann_(at)_fh-aachen.de>
;; $Author: ax006ho $
;; $Date: 2010-06-29 18:38:12 +0200 (Di, 29 Jun 2010) $
;; $Revision: 67 $
;; Keywords: tex

;;; Commentary:
;;  This file adds support for `listings-ext.sty'

;;; Code:
(TeX-add-style-hook
 "listings-ext"
 (lambda ()
   (TeX-add-symbols
    '("lstcheck" "identifier" TeX-arg-input-file 0)
    '("lstdef" "identifier" TeX-arg-input-file "line range" 0)
    '("lstuse" ["options"] "identifier"0))

   ;; Filling

   ;; Fontification
   (when (and (featurep 'font-latex)
              (eq TeX-install-font-lock 'font-latex-setup))
     (add-to-list 'font-latex-match-function-keywords-local "lstcheck")
     (add-to-list 'font-latex-match-function-keywords-local "lstdef")
     (add-to-list 'font-latex-match-function-keywords-local "lstuse")
     (font-latex-match-function-make)
     ;; For syntactic fontification, e.g. verbatim constructs
     (font-latex-set-syntactic-keywords)
     ;; Tell font-lock about the update.
     (setq font-lock-set-defaults nil)
     (font-lock-set-defaults))))

;; preparing of environments isn't necessary

;; support for options
(defvar LaTeX-listings-ext-package-options nil
  "Package options for the listings-ext package.")

;;; listings-ext.el ends here.
