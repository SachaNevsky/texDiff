;; utf8math.el                               -*- coding: utf-8 -*-

;; Copyright (C) 2004 Wlodek Bzyl


;; This file aims to provide an intuitive input method `utf8math' 
;; to input UTF-8 encoded math symbols defined in plain TeX, LaTeX
;; and other TeX macro files. To input `α' it suffices to write 
;; `/alpha', `⇔' -- /Leftrightarrow, etc.

;; The code below was taken from `u8tex.el' by Sergei Pokrovsky 
;; (to be found on any CTAN server: support/emacs-modes/u8tex.el).
;; It differs from the orignal code. The stuff not relevant 
;; to math was removed and several wrong UTF-8 codes were corrected.


;; Author: W{\l}odek Bzyl
;; Maintainer: matwb@univ.gda.pl
;; Keywords: unicode, math, mule, input method, EncTeX


;; This file is not a part of GNU Emacs.

;; GNU Emacs is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation; either version 2, or (at your option)
;; any later version.

;; GNU Emacs is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with GNU Emacs; see the file COPYING.  If not, write to the
;; Free Software Foundation, Inc., 59 Temple Place - Suite 330,
;; Boston, MA 02111-1307, USA.


;; Installation
;;
;; All you need to do is copy this file to any directory on your 
;; load-path (`C-h v load-path' shows all directories on the load-path) 
;; and add the following code:
;;
;; (register-input-method
;;  "utf8math" "utf-8" 'quail-use-package
;;  ""Unicode input using TeX macro names"
;;  "utf8math")
;;
;; to one of the Emacs initialization files, for example to `.emacs'
;; or to `.../emacs/20.*/leim/leim-list.el'.
;; After that you can switch to the utf8math input method
;; in the usual way `C-x C-m C-\ utf8math' or by choosing input
;; method from the menu:
;; Options -> Mule -> Select Input Method  utf8math
 

;;; Code:

(require 'quail)

(quail-define-package
 "utf8math" "utf-8" "∑∫" t
 "Input Unicode characters using TeX macro names.
Use slash (/) instead of backslash as Mule escape:
to get `alpha' write /alpha, to get `integral' write `/int' etc.  
" nil t nil nil nil nil nil nil nil nil t)

(quail-define-rules

 ;; Typographic symbols

 ("''" ?”) ("``" ?“)
 ("/lq" ?‘) ("/rq" ?’)
 ("/flqq" ?«) ("/frqq" ?»)      ; French double quotes
 ("/flq" ?‹)  ("/frq" ?›)       ; French double quotes
 ("/glqq" ?„) ("/grqq" ?‟)      ; German double quotes
 ("/glq" ?‚)  ("/grq" ?‛)       ; German single quotes
 ("/dots" ?…)
 ("/plqq" ?„) ("/plrq" ?”)      ; Polish double quotes

 ("/--" ?–)    ; 2013 (EN DASH)
 ("/---" ?—)   ; 2014 (EM DASH)

 ("/cent" ?¢)     ; after HTML and wasy
 ("/pound" ?£)    ; after HTML
 ("/euro" ?€)     ; \texteuro
 ("/yen" ?¥)      ; \textyen

 ;; Lowercase Greek letters
 ;; (the missing caps like \Alpha come first)

 ("/Alpha" ?Α) ("/alpha" ?α)
 ("/Beta" ?Β) ("/beta" ?β)
 ("/gamma" ?γ) ("/Gamma" ?Γ)
 ("/delta" ?δ) ("/Delta" ?Δ)
 ("/Epsilon" ?Ε) ("/epsilon" ?ε)
 ("/Zeta" ?Ζ) ("/zeta" ?ζ)
 ("/Eta" ?Η) ("/eta" ?η)
 ("/theta" ?θ) ("/vartheta" ?ϑ) ("/Theta" ?Θ)
 ("/Iota" ?Ι) ("/iota" ?ι)
 ("/Kappa" ?Κ) ("/kappa" ?κ)
 ("/lambda" ?λ) ("/Lambda" ?Λ)
 ("/Mu" ?Μ) ("/mu" ?μ)
 ("/Nu" ?Ν) ("/nu" ?ν)
 ("/Omicron" ?Ο) ("/omicron" ?ο)
 ("/xi" ?ξ) ("/Xi" ?Ξ)
 ("/pi" ?π) ("/varpi" ?ϖ) ("/Pi" ?Π)
 ("/Rho" ?Ρ) ("/rho" ?ρ) ("/varrho" ?ϱ)
 ("/sigma" ?σ) ("/varsigma" ?ς) ("/Sigma" ?Σ)
 ("/Tau" ?Τ) ("/tau" ?τ)
 ("/upsilon" ?υ) ("/Upsilon" ?Υ)
 ("/phi" ?ϕ) ("/varphi" ?φ) ("/Phi" ?Φ)
 ("/Chi" ?Χ) ("/chi" ?χ)
 ("/psi" ?ψ) ("/Psi" ?Ψ)
 ("/omega" ?ω) ("/Omega" ?Ω)

 ;; Miscellaneous symbols

 ("/aleph" ?ℵ) ("/beth" ?ℶ) ("/gimel" ?ℷ) ("/daleth" ?ℸ)
 ("/hbar" ?ℏ)
 ("/imath" ?ı)
 ("/ell" ?ℓ)
 ("/wp" ?℘)
 ("/Re" ?ℜ) ("/Im" ?ℑ)
 ("/partial" ?∂)
 ("/infty" ?∞)
 ("/prime" ?′)
 ("/emptyset" ?∅)
 ("/nabla" ?∇)
 ("/surd" ?√)
 ("/top" ?⊤)
 ("/bot" ?⊥)
 ("/|" ?∥)
 ("/angle" ?∠)
 ("/triangle" ?△)
 ("/backslash" ?\\)
 ("//" ?/) ; special !!
 ("/forall" ?∀) ("/exists" ?∃)
 ("/neg" ?¬)
 ("/flat" ?♭) ("/natural" ?♮) ("/sharp" ?♯)
 ("/clubsuit" ?♣) ("/diamondsuit" ?♢)
 ("/heartsuit" ?♡) ("/spadesuit" ?♠)
 ("/mho" ?℧) ("/complement" ?∁) ("/lozenge" ?◊) ; amssymb
 ("/square" ?□) ("/blacksquare" ?■) ; amssymb
 ("/barwedge" ?⊼) ("/veebar" ?⊻) ; amssymb

 ;; “Large” operators

 ("/sum" ?∑)
 ("/prod" ?∏)
 ("/coprod" ?∐)
 ("/int" ?∫)
 ("/oint" ?∮)
 ("/bigcap" ?⋂)
 ("/bigcup" ?⋃)
 ("/bigvee" ?⋁)
 ("/bigwedge" ?⋀)

 ;; Binary operations

 ("/pm" ?±) ("/mp" ?∓)
 ("/setminus" ?∖)
 ("/cdot" ?⋅) ("/times" ?×)
 ("/ast" ?∗) ("/star" ?⋆)
 ("/diamond" ?⋄)
 ("/circ" ?∘)
 ("/bullet" ?∙)
 ("/div" ?÷)
 ("/cap" ?∩) ("/cup" ?∪)
 ("/uplus" ?⊎)
 ("/sqcap" ?⊓) ("/sqcup" ?⊔)
 ("/triangleleft" ?◃) ; changed on 10.VII.2004
 ("/triangleright" ?▹) ; ditto
 ("/wr" ?≀)
 ("/bigcirc" ?◯)
 ("/bigtriangleup" ?△) ("/bigtriangledown" ?▽)
 ("/vee" ?∨) ("/wedge" ?∧)
 ("/oplus" ?⊕) ("/ominus" ?⊖)
 ("/otimes" ?⊗) ("/oslash" ?⊘)
 ("/odot" ?⊙)
 ("/dagger" ?†) ("/ddagger" ?‡)
 ("/amalg" ?∐)

 ;; Relations

 ("/leq" ?≤)
 ("/prec" ?≺) ("/preceq" ?≼)
 ("/ll" ?≪)
 ("/subset" ?⊂) ("/subseteq" ?⊆)
 ("/sqsubseteq" ?⊑)
 ("/in" ?∈)
 ("/vdash" ?⊢)
 ("/smile" ?⌣)
 ("/frown" ?⌢)
 ("/geq" ?≥)
 ("/succ" ?≻) ("/succeq" ?≽)
 ("/gg" ?≫)
 ("/supset" ?⊃) ("/supseteq" ?⊇)
 ("/sqsupseteq" ?⊒)
 ("/ni" ?∋)
 ("/dashv" ?⊣)
 ("/mid" ?∣)
 ("/parallel" ?∥)
 ("/equiv" ?≡)
 ("/sim" ?∼) ("/simeq" ?≃)
 ("/asymp" ?≍)
 ("/approx" ?≈)
 ("/cong" ?≅)
 ("/bowtie" ?⋈)
 ("/propto" ?∝)
 ("/models" ?⊧) ; changed on 10 July 2004
 ("/doteq" ?≐)
 ("/perp" ?⊥)

 ;; Negated relations

 ("/not<" ?≮)
 ("/not/leq" ?≰)
 ("/not/prec" ?⊀) ("/not/preceq" ?⋠)
 ("/not/subset" ?⊄) ("/not/subseteq" ?⊈)
 ("/not/sqsubseteq" ?⋢)
 ("/not>" ?≯)
 ("/not/geq" ?≱)
 ("/not/succ" ?⊁) ("/not/succeq" ?⋡)
 ("/not/supset" ?⊅) ("/not/supseteq" ?⊉)
 ("/not/sqsupseteq" ?⋣)
 ("/not=" ?≠)
 ("/not/equiv" ?≢)
 ("/not/sim" ?≁) ("/not/simeq" ?≄)
 ("/not/approx" ?≉)
 ("/not/cong" ?≇)
 ("/not/asymp" ?≭)

 ;; Arrows

 ("/leftarrow" ?←) ("/Leftarrow" ?⇐)
 ("/rightarrow" ?→) ("/Rightarrow" ?⇒)
 ("/leftrightarrow" ?↔) ("/Leftrightarrow" ?⇔)
 ("/mapsto" ?↦)
 ("/hookleftarrow" ?↩)
 ("/leftharpoonup" ?↼)
 ("/leftharpoondown" ?↽)
 ("/rightleftharpoons" ?⇌)
 ("/hookrightarrow" ?↪)
 ("/rightharpoonup" ?⇀)
 ("/rightharpoondown" ?⇁)
 ("/searrow" ?↘)
 ("/swarrow" ?↙)
 ("/nwarrow" ?↖)
 ("/uparrow" ?↑) ("/Uparrow" ?⇑)
 ("/downarrow" ?↓) ("/Downarrow" ?⇓)
 ("/updownarrow" ?↕) ("/Updownarrow" ?⇕)
 ("/nearrow" ?↗)

 ;; Openings       ;; Closings    
                                  
 ("/lfloor" ?⌊)   ("/rfloor" ?⌋)
 ("/langle" ?⟨)   ("/rangle" ?⟩) ; changed on 10 July 2004
 ("/lceil"  ?⌈)   ("/rceil"  ?⌉) 

 ;; Alternate names

 ("/ne" ?≠) ("/neq" ?≠)
 ("/le" ?≤) ("/ge" ?≥)
 ("/to" ?→)
 ("/gets" ?←)
 ("/owns" ?∋)
 ("/land" ?∧)
 ("/lor" ?∨)
 ("/lnot" ?¬)
 ("/vert" ?∣)
 ("/Vert" ?∥)

 ;; Non-math symbols

 ("/S" ?§) ("/P" ?¶)
 ("/dag" ?†) ("/ddag" ?‡)
 ("/brokenbar" ?¦)
 ("/brvbar" ?¦) ; like in HTML
 ("/reg" ?®)    ; like in HTML, unlike TeX's /registered
 ("/trade" ?™)  ; like in HTML
 ("/frownie" ?☹)
 ("/smiley" ?☺)
 ("/blacksmiley" ?☻)

 ;; Combining characters

 ("/'{}" ?́)
 ("/`{}" ?̀)
 ("/^{}" ?̂)
 ("/\"{}" ?̈)
 ("/~{}" ?̃)
 ("/={}" ?¯) ; or else COMBINING MACRON = ("/={}" ?̄) ?
 ("/.{}" ?̇)
 ("/u{}" ?̆)
 ("/v{}" ?̌)
 ("/H{}" ?̋)
 ("/t{}" ?͡)
 ("/c{}" ?̧)
 ("/d{}" ?̣)
 ("/b{}" ?̱)

 ;; \mathbb

 ("/bbC" ?ℂ) ("/bbH" ?ℍ) ("/bbN" ?ℕ) ("/bbP" ?ℙ)
 ("/bbQ" ?ℚ) ("/bbR" ?ℝ) ("/bbZ" ?ℤ)
 
)

;;; utf8math.el ends here
