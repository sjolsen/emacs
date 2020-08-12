;;; This function should serve as a common entry point for site-specific
;;; configuration. Load this file from .emacs and save any further
;;; customizations there.

;; Make .emacs.d/custom available
(let* ((prelude-file (file-truename (or load-file-name (buffer-file-name))))
       (prelude-dir  (file-name-directory prelude-file)))
  (load-file (concat prelude-dir "/custom/load-utility.el"))
  (add-to-load-path (concat prelude-dir "/custom"))
  (customize-set-variable 'custom-theme-directory (concat prelude-dir "/themes")))

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
