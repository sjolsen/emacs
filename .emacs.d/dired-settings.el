(defcustom dired-mode-hook nil
  "*Hook called by `dired-mode'."
  :type 'hook
  :group 'dired)

(add-hook 'dired-mode-hook
  (lambda () (local-set-key (kbd "<mouse-2>") 'dired-find-file)))
