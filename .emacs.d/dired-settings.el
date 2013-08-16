(defcustom dired-mode-hook nil
  "*Hook called by `dired-mode'."
  :type 'hook
  :group 'dired)

(defun dired-find-file-other-window-at-mouse (mouse-event)
  (interactive "e")
  (save-excursion
    (mouse-set-point mouse-event)
    (dired-find-file-other-window)))

(add-hook 'dired-mode-hook
  (lambda () (local-set-key (kbd "<mouse-2>") 'dired-find-file-other-window-at-mouse)))
