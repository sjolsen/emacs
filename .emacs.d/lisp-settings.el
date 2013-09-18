;;; Basic (e)lisp settings

(let ((mode-hooks '(lisp-mode-hook
		    lisp-interaction-mode
		    emacs-lisp-mode-hook)))
  (mapcar (lambda (mode-hook)
            ;; Comment-region
            (add-hook mode-hook
                      (lambda ()
                        (local-set-key (kbd "C-c C-c") 'comment-region)))

            ;; Indent on newline
	    (add-hook mode-hook
		      (lambda ()
			(local-set-key (kbd "C-m") 'newline-and-indent)))

	    ;; Navigate parens
	    (add-hook mode-hook 'navigate-parens-mode)

            ;; No tabs
	    (add-hook mode-hook
		      (lambda ()
			(setq indent-tabs-mode nil))))
          mode-hooks))

;; Add sexp closing to slime
(add-hook 'slime-repl-mode-hook
          (lambda () (local-set-key (kbd "C-c C-q") 'slime-close-all-parens-in-sexp)))

;; Add all .emacs* files
(add-to-list 'auto-mode-alist '("\\.emacs" . emacs-lisp-mode))
