(deftheme latex-settings
  "Settings for LaTeX.")

(custom-theme-set-variables
 'latex-settings
 '(font-latex-match-sectioning-1-keywords (quote (("problem" "*{{"))))
 '(font-latex-match-sectioning-2-keywords (quote (("subproblem" "*{{"))))
 '(TeX-PDF-mode t))

(provide-theme 'latex-settings)
