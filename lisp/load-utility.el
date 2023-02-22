;;; -*- lexical-binding: t -*-
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
   (concat user-emacs-directory (convert-standard-filename subdir))
   recursive))



(defalias 'λ 'lambda)
(font-lock-add-keywords 'emacs-lisp-mode
                        '(("λ" . font-lock-keyword-face)))

(defun make-alist (conses)
  (let ((cons-eval (λ (cell)
                     (cons (eval (car cell))
                           (eval (cdr cell))))))
    (mapcar cons-eval conses)))

(defun make-insert-command (char)
  (λ (&optional arg)
    (interactive "P")
    (insert-char char (or arg 1))))

(defun keymap-insert-cons (keymap binding)
  (define-key keymap (read-kbd-macro (car binding)) (cdr binding)))

(defun define-keys-for-map (mode-map binding-alist)
  "Adds the definitions given by `binding-alist' to the mode map passed in
`mode-map'. `binding-alist' should be an a-list mapping key sequences (using
the kbd-macro syntax) to commands."
  (mapcar (λ (binding)
            (keymap-insert-cons mode-map binding))
          binding-alist))

(defmacro define-keys (mode &rest key-defs)
  "Adds the given key definitions to the keymap for the specified mode. This is
performed lazily using the mode's hook."
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


;;; TODO: Find a good place for this

(defun custom-standard-value (symbol)
  (eval (car (get symbol 'standard-value))))

(defun remove-all (l1 l2)
  "Remove all occurrences of elements of `l1' from `l2'"
  (if l1
      (remove-all (cl-rest l1) (remove (cl-first l1) l2))
    l2))

(provide 'load-utility)
