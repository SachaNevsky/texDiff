;;; arabluatex.el --- AUCTeX style for `arabluatex.sty'
;; This file is part of the `arabluatex' package

;; ArabLuaTeX -- Processing ArabTeX notation under LuaLaTeX
;; Copyright (C) 2016--2020  Robert Alessi

;; Please send error reports and suggestions for improvements to Robert
;; Alessi <alessi@robertalessi.net>

;; This program is free software: you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful, but
;; WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
;; General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see
;; <http://www.gnu.org/licenses/>.

(defvar LaTeX-arabluatex-preamble-options
  '(;;
    ("voc")
    ("fullvoc")
    ("novoc")
    ("trans")
    ("export" ("true" "false")))
  "Package options for the arabluatex package.")

(defun LaTeX-arabluatex-package-options ()
  "Prompt for package options for arabluatex package."
  (TeX-read-key-val t
		    (append LaTeX-arabluatex-preamble-options)))

(defvar LaTeX-arabluatex-mode-options
  '(;;
    ("voc")
    ("fullvoc")
    ("novoc")
    ("trans")
    )
  "Local options.")

(defvar LaTeX-arabluatex-key-val-options
  '(;;
    ("mode" ("voc" "fullvoc" "novoc" "trans"))
    ("width")
    ("gutter")
    ("metre")
    ("color")
    ("delim" ("true" "false"))
    ("utf" ("true" "false"))
    ("export" ("true" "false")))
  "Key=value options for arabverse environment.")

(defvar LaTeX-arabluatex-color-options
  '(()))

(defvar LaTeX-arabluatex-outfile-options
  '(;;
    ("newline"))
  "Option for outfile command.")

(defvar LaTeX-arabluatex-arbmark-options
  '(;;
    ("rl")
    ("lr"))
  "Option for arbmark command.")

(TeX-add-style-hook
 "arabluatex"
 (lambda ()
   ;; This package relies on lualatex, so check for it:
   (TeX-check-engine-add-engines 'luatex)
   (TeX-add-symbols
    "aemph"
    "SetInputScheme"
    '("SetArbEasy" 0)
    '("SetArbDflt" 0)
    '("SetArbEasy*" 0)
    '("SetArbDflt*" 0)
    "SetTranslitFont"
    "SetTranslitStyle"
    "SetTranslitConvention"
    "SetArbOutSuffix"
    "arbup"
    '("ArbUpDflt" 0)
    '("NoArbUp" 0)
    "SetArbUp"
    "uc"
    "prname"
    "txarb"
    '("arb" [ (TeX-arg-eval completing-read "Mode: "
			    LaTeX-arabluatex-mode-options) ]
      t)
    '("arbcolor" [ (TeX-arg-eval completing-read "Color: "
			    LaTeX-arabluatex-color-options) ]
      t)
    '("arbmark" [ (TeX-arg-eval completing-read "Option: "
			    LaTeX-arabluatex-arbmark-options) ]
      t)
    '("ArbOutFile" [ (TeX-arg-eval completing-read "Color: "
			    LaTeX-arabluatex-outfile-options) ]
      t)
    '("ArbOutFile*" [ (TeX-arg-eval completing-read "Option: "
			    LaTeX-arabluatex-outfile-options) ]
      t)
    "SetHemistichDelim"
    '("bayt" 2)
    "abjad"
    "arbnull"
    "abraces"
    "LR"
    "RL"
    "LRmarginpar"
    "LRfootnote"
    "RLfootnote"
    "FixArbFtnmk"
    "MkArbBreak"
    '("newarbmark" 3)
    '("setRL" 0)
    '("setLR" 0))
   (LaTeX-add-environments
    '("arab" LaTeX-env-args
      [ (TeX-arg-eval completing-read "Mode: "
		      LaTeX-arabluatex-mode-options) ]
      0)
    "txarab"
    "arabexport"
    '("arabverse" LaTeX-env-args
      [ TeX-arg-key-val LaTeX-arabluatex-key-val-options ] 0))
   )
 LaTeX-dialect)

;;; arabluatex.el ends here
