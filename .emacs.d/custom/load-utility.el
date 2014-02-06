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

(defun make-alist (conses)
  (let ((cons-eval (λ (cell)
                     (cons (eval (car cell))
                           (eval (cdr cell))))))
    (mapcar cons-eval conses)))

(defun define-keys-for-map (mode-map binding-alist)
  "Adds the definitions given by `binding-alist' to the mode map passed in
`mode-map'. `binding-alist' should be an a-list mapping key sequences (using
the kbd-macro syntax) to commands."
  (mapcar (λ (binding)
            (define-key mode-map (read-kbd-macro (car binding)) (cdr binding)))
          binding-alist))

(defmacro define-keys (mode &rest key-defs)
  (let ((mode-map (intern (concat (symbol-name mode) "-map")))
        (mode-hook (intern (concat (symbol-name mode) "-hook")))
        (binding-alist (make-alist key-defs)))
    `(add-hook ',mode-hook (λ ()
                             (define-keys-for-map ,mode-map ',binding-alist)))))

(defmacro define-keys-globally (&rest key-defs)
  `(define-keys-for-map (current-global-map) (make-alist ',key-defs)))

(font-lock-add-keywords 'emacs-lisp-mode
                        '(("define-keys-for-map"  . font-lock-keyword-face)
                          ("define-keys-globally" . font-lock-keyword-face)
                          ("define-keys"          . font-lock-keyword-face)))

(provide 'load-utility)
