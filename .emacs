(add-to-list 'load-path "~/.emacs.d/")

;; auto-complete
(add-to-list 'load-path "~/.emacs.d/auto-complete")
(add-to-list 'load-path "~/.emacs.d/auto-complete/lib/ert")
(add-to-list 'load-path "~/.emacs.d/auto-complete/lib/fuzzy")
(add-to-list 'load-path "~/.emacs.d/auto-complete/lib/popup")
(setq-default ac-sources '(ac-source-filename))
(require 'auto-complete-config)
(add-to-list 'ac-dictionary-directories "~/.emacs.d//ac-dict")
(ac-config-default)
(setq ac-ignore-case nil)
(add-hook 'auto-complete-mode-hook
          (lambda ()
            (define-key ac-completing-map (kbd "RET") nil)
            (define-key ac-completing-map (kbd "<C-return>") 'ac-complete)
            (define-key ac-completing-map (kbd "C-n") nil)
            (define-key ac-completing-map (kbd "<down>") nil)
            (define-key ac-completing-map (kbd "C-p") nil)
            (define-key ac-completing-map (kbd "<up>") nil)))
(add-to-list 'load-path "~/.emacs.d/auto-complete-clang")
(require 'auto-complete-clang)
(add-to-list 'load-path "~/.emacs.d/auto-complete-etags")
(require 'auto-complete-etags)
(define-key ac-completing-map [return] nil)
(define-key ac-completing-map "\r" nil)



(load "basic-bindings")
(load "c-c++-settings")
(unless (string< emacs-version "24")
  (load "elpa-settings"))
(load "dired-settings")
(load "hscroll")
(load "hyper-greek")
(load "lisp-settings")
(load "magit-settings")
(load "navigate-parens-mode")
(load "org-settings")
(load "visual-settings")
(load "term-settings")
(load "shell-settings")
(if (file-exists-p "~/Documents/configs/rcirc-settings.el")
    (load-file "~/Documents/configs/rcirc-settings.el"))

;; Yasnippet
;(add-to-list 'load-path "~/.emacs.d/yasnippet")
;(require 'yasnippet)
;(yas/reload-all)

;; Show parens
(show-paren-mode)

;; Multiple cursors
(add-to-list 'load-path "~/.emacs.d/multiple-cursors")
(require 'multiple-cursors)

;; dired-x
(add-hook 'dired-load-hook
          (lambda ()
            (load "dired-x")
            ;; Set dired-x global variables here.  For example:
            ;; (setq dired-guess-shell-gnutar "gtar")
            ;; (setq dired-x-hands-off-my-keys nil)
            (setq dired-omit-files "^\\.[^.]+\\|.+~")
                  ;(concat dired-omit-files "\\|^\\..+$"))
            ))
(add-hook 'dired-mode-hook
          (lambda ()
            ;; Set dired-x buffer-local variables here.  For example:
            (setq dired-omit-files-p t)
            ))

;; Prettified line breaks (^L)
(require 'page-break-lines)

;; Undo Tree
(add-to-list 'load-path "~/.emacs.d/undo-tree")
(require 'undo-tree)
(global-undo-tree-mode)
(define-key undo-tree-map (kbd "C-?") nil)
(define-key undo-tree-map (kbd "C-S-z") 'undo-tree-redo)

;; Minimap
(require 'minimap)

;; Flymake
(require 'flymake-settings)
(flymake-settings)

;; Magit
(global-set-key (kbd "C-x g") 'magit-status)

;; Flex and Bison
;; (load "flex-mode")
;; (load "bison-mode")
;; (add-to-list 'auto-mode-alist '("\\.y$" . bison-mode))
;; (add-to-list 'auto-mode-alist '("\\.l$" . flex-mode))

;; Makefile association
(add-to-list 'auto-mode-alist
             '("[Mm]akefile.*" . makefile-mode))

;; Customizations
(load-file "~/.emacs.d/custom-settings.el")
