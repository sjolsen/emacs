;;; load-utility.el --- utilities to be used by Emacs' load files

(defun add-user-subdir-to-load-path (subdir)
  "Add a new subdirectory from `user-emacs-directory' (typically
~/.emacs.d) to the load path."
  (add-to-list 'load-path
	       (concat user-emacs-directory (convert-standard-filename subdir))))



(defalias 'λ 'lambda)
(font-lock-add-keywords 'emacs-lisp-mode
                        '(("λ" . font-lock-keyword-face)))

(defmacro define-keys-for-map (mode-map &rest key-defs)
  "Adds the definitions given by `key-defs' to the mode map bound to
the symbol passed as `mode-map'. `key-defs' should be an a-list
mapping key sequences (using the kbd-macro syntax) to commands."
  `(mapcar (λ (key-def)
             (define-key ,mode-map (read-kbd-macro (eval (car key-def))) (eval (cdr key-def))))
           ',key-defs))

(defmacro define-keys (mode &rest key-defs)
  (let ((mode-map (intern (concat (symbol-name mode) "-map")))
        (mode-hook (intern (concat (symbol-name mode) "-hook"))))
    `(add-hook ',mode-hook (λ ()
                             (define-keys-for-map ,mode-map ,@key-defs)))))

(defmacro define-keys-globally (&rest key-defs)
  `(define-keys-for-map (current-global-map) ,@key-defs))

(font-lock-add-keywords 'emacs-lisp-mode
                        '(("define-keys-for-map"  . font-lock-keyword-face)
                          ("define-keys-globally" . font-lock-keyword-face)
                          ("define-keys"          . font-lock-keyword-face)))

(provide 'load-utility)
