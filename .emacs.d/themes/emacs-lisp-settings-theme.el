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

(define-keys emacs-lisp-mode
  ("<return>" . #'newline-and-indent))

(define-keys-globally
  ("C-c e" . #'eval-and-replace))


;; Auto-complete settings

(defvar *emacs-lisp-ac-sources*
  '(ac-source-functions
    ac-source-variables
    ac-source-symbols
    ac-source-features))

(add-hook 'emacs-lisp-mode-hook
          (λ ()
            (when (featurep 'auto-complete)
              (setq ac-sources *emacs-lisp-ac-sources*))))



(custom-theme-set-variables
 'emacs-lisp-settings
 '(emacs-lisp-docstring-fill-column nil))

(provide-theme 'emacs-lisp-settings)
