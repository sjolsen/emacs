;;; This function should serve as a common entry point for site-specific
;;; configuration. Load this file from .emacs and save any further
;;; customizations there.

(load-file (concat user-emacs-directory "/custom/load-utility.el"))
(add-user-subdir-to-load-path "custom")
(add-user-subdir-to-load-path "external" t)

(defvar *available-themes*
  '(auto-complete
    basic-desktop
    cc-settings
    dired-settings
    editing
    elpa-settings
    emacs-lisp-settings
    info-settings
    latex-settings
    lisp-settings
    magit-settings
    sjo-color
    slime))
