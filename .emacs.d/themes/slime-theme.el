(deftheme slime
  "Settings for SLIME")

(autoload 'slime "slime" nil t)
(eval-after-load "slime"
  '(progn
     (slime-setup '(slime-fancy slime-fuzzy slime-repl))
     (define-keys slime-repl-mode
       ("<tab>" . #'slime-fuzzy-indent-and-complete-symbol))))



(provide-theme 'slime)
