(deftheme emacs-lisp-settings
  "Settings for Emacs Lisp")

(defun eval-and-replace ()
  "Replace the preceding sexp with its value."
  (interactive)
  (backward-kill-sexp)
  (prin1 (eval (read (current-kill 0)))
         (current-buffer)))

(defun byte-compile-contrib (&optional recompile)
  "(Re)compile Emacs Lisp files in elpa and external directories"
  (interactive "P")
  (byte-recompile-directory (concat user-emacs-directory "/elpa") 0 recompile)
  (byte-recompile-directory (concat user-emacs-directory "/external") 0 recompile))

(define-keys-globally
  ("C-c e" . #'eval-and-replace))



(custom-theme-set-variables
 'emacs-lisp-settings
 '(emacs-lisp-docstring-fill-column nil))

(provide-theme 'emacs-lisp-settings)
