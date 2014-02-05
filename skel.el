;;; This function should serve as a common entry point for site-specific
;;; configuration. Load this file from .emacs and save any further
;;; customizations there.

(load-file (concat user-emacs-directory "/custom/load-utility.el"))
(add-user-subdir-to-load-path "custom")
