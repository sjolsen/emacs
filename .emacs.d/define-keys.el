(defmacro define-keys (mode &rest key-defs)
  (let ((mode-map (intern (concat (symbol-name mode) "-map")))
        (mode-hook (intern (concat (symbol-name mode) "-hook"))))
    `(add-hook ',mode-hook (lambda ()
       (mapcar (lambda (key-def)
                 (define-key ,mode-map (eval (kbd (car key-def))) (eval (cdr key-def))))
               ',key-defs)))))

(font-lock-add-keywords 'emacs-lisp-mode
                        '(("define-keys" . font-lock-keyword-face)))

(provide 'define-keys)
