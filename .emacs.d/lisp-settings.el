;;; Basic SLIME/Elisp settings

;; Slime autodoc for Lisp mode
(add-hook 'lisp-mode-hook
          '(lambda ()
             ;; (local-set-key "\t" '(lambda () (interactive)
             ;;                        (slime-indent-and-complete-symbol)))
             (local-set-key (kbd "C-m") '(lambda () (interactive)
                                           (newline-and-indent)))))

;; No tabs in (e)lisp
(add-hook 'emacs-lisp-mode-hook
          (lambda ()
            (setq indent-tabs-mode nil)))
(add-hook 'lisp-mode-hook
          (lambda ()
            (setq indent-tabs-mode nil)))

;; Add sexp closing to slime/lisp
(add-hook 'slime-repl-mode-hook
          '(lambda () (local-set-key (kbd "C-c C-q") 'slime-close-all-parens-in-sexp)))

;; Add all .emacs* files
(add-to-list 'auto-mode-alist '("\\.emacs" . emacs-lisp-mode))
