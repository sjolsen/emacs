(deftheme emacs-lisp-settings
  "Settings for Emacs Lisp")

(defun eval-and-replace ()
  "Replace the preceding sexp with its value."
  (interactive)
  (backward-kill-sexp)
  (prin1 (eval (read (current-kill 0)))
         (current-buffer)))

(define-keys-globally
  ("C-c e" . #'eval-and-replace))



(custom-theme-set-variables
 'emacs-lisp-settings
 '(emacs-lisp-docstring-fill-column nil))

(provide-theme 'emacs-lisp-settings)
