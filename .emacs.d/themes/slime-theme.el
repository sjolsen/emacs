(deftheme slime
  "Settings for SLIME")

(define-keys slime-repl-mode
      ("<tab>" . #'slime-fuzzy-indent-and-complete-symbol))

(eval-after-load 'slime
  (slime-setup '(slime-fancy slime-fuzzy slime-repl)))



(provide-theme 'slime)
