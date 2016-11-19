;;; This function should serve as a common entry point for site-specific
;;; configuration. Load this file from .emacs and save any further
;;; customizations there.

;; Make .emacs.d/custom available
(load-file (concat user-emacs-directory "/custom/load-utility.el"))
(add-user-subdir-to-load-path "custom")

;; Make .emacs.d/external available
(when (file-exists-p (concat user-emacs-directory "/external"))
  (add-user-subdir-to-load-path "external" t))

;; (Prompt to) install required ELPA packages
(require 'elpa-settings)
(install-elpa-packages)

(defvar *available-themes*
  '(auto-complete
    basic-desktop
    cc-settings
    dired-settings
    editing
    emacs-lisp-settings
    info-settings
    latex-settings
    lisp-settings
    magit-settings
    sjo-color
    slime))
