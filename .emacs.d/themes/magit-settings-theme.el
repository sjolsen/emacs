(deftheme magit-settings
  "Settings for Magit")

(global-set-key (kbd "C-x g") 'magit-status)

(define-keys magit-log-edit-mode
  ("C-x C-s" . #'git-commit-commit))

(provide-theme 'magit-settings)
