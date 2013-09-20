;;; Settings for Magit

(add-hook 'magit-log-edit-mode-hook
          (lambda ()
            (local-set-key (kbd "C-x C-s") 'git-commit-commit)))
