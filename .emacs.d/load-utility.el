;;; load-utility.el --- utilities to be used by Emacs' load files

(defun add-user-subdir-to-load-path (subdir)
  "Add a new subdirectory from `user-emacs-directory' (typically
~/.emacs.d) to the load path."
  (add-to-list 'load-path
	       (concat user-emacs-directory (convert-standard-filename subdir))))



(defalias 'λ 'lambda)
(font-lock-add-keywords 'emacs-lisp-mode
                        '(("λ" . font-lock-keyword-face)))

(defmacro define-keys (mode &rest key-defs)
  (let ((mode-map (intern (concat (symbol-name mode) "-map")))
        (mode-hook (intern (concat (symbol-name mode) "-hook"))))
    `(add-hook ',mode-hook (λ ()
       (mapcar (λ (key-def)
                 (define-key ,mode-map (read-kbd-macro (eval (car key-def))) (eval (cdr key-def))))
               ',key-defs)))))

(font-lock-add-keywords 'emacs-lisp-mode
                        '(("define-keys" . font-lock-keyword-face)))

(provide 'load-utility)
