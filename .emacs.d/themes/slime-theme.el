(deftheme slime
  "Settings for SLIME")

(autoload 'slime "slime" nil t)
(eval-after-load "slime"
  '(progn
     (slime-setup '(slime-fancy slime-fuzzy slime-repl))
     (add-hook 'slime-repl-mode-hook (λ ()
                                       (when (featurep 'auto-complete)
                                         (require 'ac-slime-fuzzy)
                                         (setq ac-sources '(ac-slime-fuzzy:*ac-source*)))))
     (define-keys slime-repl-mode
       ("<tab>"   . #'slime-fuzzy-indent-and-complete-symbol)
       ("C-c C-d" . nil))))



(provide-theme 'slime)
