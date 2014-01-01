(deftheme magit-settings
  "Settings for Magit")

(global-set-key (kbd "C-x g") 'magit-status)

(define-keys git-commit-mode
  ("C-x C-s" . #'git-commit-commit))

(provide-theme 'magit-settings)
