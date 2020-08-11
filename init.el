;; Allow loading this Emacs configuration without modifying the user's primary
;; configuration. Can be loaded either with "emacs -q -l /path/to/init.el" or by
;; pointing ~/.emacs at init.el.
(let ((init-file (or load-file-name (buffer-file-name))))
  (setq user-init-file (file-truename init-file)))
(setq user-emacs-directory (file-name-directory user-init-file))
(message "Loaded Emacs configuration from %s" user-init-file)
