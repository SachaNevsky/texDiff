;; file: texsis.el (TeXsis version 2.18)
;; @(#) $Revision: 18.3 $ / $Date: 1998/09/26 23:57:01 $ / $Author: myers $
;;======================================================================*
; GNU emacs support for TeXsis (A TeX macro package for Physicists)
;
; The function texsis-mode makes TeXsis the version of TeX run by the
; commands TeX-buffer and TeX-region.  If the mode is not already
; "TeX" then plain-tex-mode is invoked first.
;
; The function look-for-texsis looks for "\texsis" (or actually, just
; the word "texsis") and sets texsis-mode if such is found.  Put this
; in your TeX-mode-hook to automatically set texsis-mode for TeXsis files.
;
; This file is a part of TeXsis.
;
; Eric Myers, University of Texas at Austin, 22 September 1990
; (with help from lion@navier.stanford.edu -- thanks, leo.)
;======================================================================*

(defun look-for-texsis ()
  "search for \"texsis\" within first 256 characters of the file.
If found, turn on texsis-mode." 
  (goto-char (point-min))
  (if (search-forward "texsis" (min (point-max) (+ (point-min) 255)) t) 
     (texsis-mode))
)


(defun texsis-mode ()  "TeX mode for processing TeXsis files."
  (if (or (equal mode-name "TeX") (equal mode-name "TeXsis") )
      (progn
	(setq TeX-command "texsis")      ;; emacs 18.xx 
	(setq tex-command "texsis")      ;; emacs 19.xx
	(setq mode-name "TeXsis")        ;; mode name is TeXsis
	(goto-char (point-min))
	(message "TeXsis mode.")
	)

    ;; if not a TeX mode then first invoke plain-tex-mode

    (progn
      (plain-tex-mode)
      (if (not (equal mode-name "TeXsis")) (texsis-mode) )
      )  
  )
)