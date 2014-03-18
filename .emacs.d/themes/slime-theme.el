(deftheme slime
  "Settings for SLIME")

(define-keys slime-repl-mode
      ("<tab>" . #'slime-fuzzy-indent-and-complete-symbol))

(eval-after-load 'slime
  (slime-setup '(slime-fancy slime-fuzzy slime-repl))
  (add-hook 'slime-repl-mode-hook (λ ()
                                    (when (featurep 'auto-complete)
                                      (require 'ac-slime-fuzzy)
                                      (setq ac-sources '(ac-slime-fuzzy:*ac-source*))))))



(provide-theme 'slime)
