;;; load-utility.el --- utilities to be used by Emacs' load files

(defun add-to-load-path (pathspec &optional recursive)
  "Add a new subdirectory to `load-path', recursively if specified"
  (let ((default-directory pathspec))
    (normal-top-level-add-to-load-path '("."))
    (when recursive
      (normal-top-level-add-subdirs-to-load-path))))

(defun add-user-subdir-to-load-path (subdir &optional recursive)
  "Add a new subdirectory from `user-emacs-directory' (typically
~/.emacs.d) to the load path."
  (add-to-load-path
   (concat user-emacs-directory (convert-standard-filename subdir))))



(defalias 'λ 'lambda)
(font-lock-add-keywords 'emacs-lisp-mode
                        '(("λ" . font-lock-keyword-face)))

(defun define-keys-for-maps (mode-maps key-defs)
  "Adds the definitions given by `key-defs' to the mode map bound to
the symbols passed in `mode-maps'. `key-defs' should be an a-list
mapping key sequences (using the kbd-macro syntax) to commands."
  (mapcar (λ (key-def)
            (mapcar (λ (mode-map)
                      (define-key mode-map (read-kbd-macro (eval (car key-def))) (eval (cdr key-def))))
                    mode-maps))
          key-defs))

(defmacro define-keys (mode &rest key-defs)
  (let ((mode-map (intern (concat (symbol-name mode) "-map")))
        (mode-hook (intern (concat (symbol-name mode) "-hook"))))
    `(add-hook ',mode-hook (λ ()
                             (define-keys-for-maps (list ,mode-map) ',key-defs)))))

(defmacro define-keys-globally (&rest key-defs)
  `(define-keys-for-maps (list (current-global-map)) ',key-defs))

(font-lock-add-keywords 'emacs-lisp-mode
                        '(("define-keys-for-maps"  . font-lock-keyword-face)
                          ("define-keys-globally"  . font-lock-keyword-face)
                          ("define-keys"           . font-lock-keyword-face)))

(provide 'load-utility)
