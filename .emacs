(add-to-list 'load-path "~/.emacs.d/")

;; auto-complete
(add-to-list 'load-path "~/.emacs.d/auto-complete")
(add-to-list 'load-path "~/.emacs.d/auto-complete/lib/ert")
(add-to-list 'load-path "~/.emacs.d/auto-complete/lib/fuzzy")
(add-to-list 'load-path "~/.emacs.d/auto-complete/lib/popup")
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

(load "basic-bindings")
(load "c-c++-settings")
(unless (string< emacs-version "24")
  (load "elpa-settings"))
(load "dired-settings")
(load "hscroll")
(load "lisp-settings")
(load "magit-settings")
(load "navigate-parens-mode")
(load "org-settings")
(load "visual-settings")
(load "term-settings")
(if (file-exists-p "~/Documents/configs/rcirc-settings.el")
    (load-file "~/Documents/configs/rcirc-settings.el"))

;; Yasnippet
(add-to-list 'load-path "~/.emacs.d/yasnippet")
(require 'yasnippet)

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



(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ac-clang-flags (quote ("-std=c++11")))
 '(column-number-mode t)
 '(fci-rule-character-color nil)
 '(fci-rule-color "dim gray")
 '(font-use-system-font t)
 '(global-page-break-lines-mode t)
 '(global-semantic-idle-scheduler-mode nil)
 '(global-semanticdb-minor-mode nil)
 '(inhibit-startup-screen t)
 '(mouse-wheel-scroll-amount (quote (1 ((control)))))
 '(page-break-lines-char 45)
 '(page-break-lines-modes (quote (emacs-lisp-mode lisp-mode scheme-mode compilation-mode outline-mode help-mode c-mode c++-mode text-mode)))
 '(semantic-mode t)
 '(semantic-stickyfunc-indent-string "")
 '(show-paren-mode t)
 '(tool-bar-mode nil)
 '(tramp-default-proxies-alist (quote (("kmic.*" "\\`root\\'" "/ssh:stuart@%h:") ("\\`dakara" "\\`root\\'" "/ssh:sjo@%h:"))))
 '(truncate-lines t)
 '(yas-global-mode nil nil (yasnippet)))
(put 'upcase-region 'disabled nil)
(put 'downcase-region 'disabled nil)
;; (custom-set-faces
;;  ;; custom-set-faces was added by Custom.
;;  ;; If you edit it by hand, you could mess it up, so be careful.
;;  ;; Your init file should contain only one such instance.
;;  ;; If there is more than one, they won't work right.
;;  '(default ((t (:inherit nil :stipple nil :background "Grey15" :foreground "Grey" :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 120 :width normal :foundry "unknown" :family "Inconsolata")))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(flymake-errline ((((type tty)) (:background "red")) (default (:underline (:color "red2" :style wave)))))
 '(flymake-warnline ((((type tty)) (:background "blue")) (default (:underline (:color "medium blue" :style wave)))))
 '(header-line ((t (:foreground "grey90" :box nil))))
 '(term-color-black ((t (:background "Grey15" :foreground "Grey15"))))
 '(term-color-blue ((t (:background "#438CCA" :foreground "#438CCA"))))
 '(term-color-cyan ((t (:background "#00FFFF" :foreground "#00FFFF"))))
 '(term-color-green ((t (:background "#3BB878" :foreground "#3BB878"))))
 '(term-color-magenta ((t (:background "#F06EA9" :foreground "#F06EA9"))))
 '(term-color-red ((t (:background "#F7977A" :foreground "#F7977A"))))
 '(term-color-white ((t (:background "Grey" :foreground "Grey"))))
 '(term-color-yellow ((t (:background "#FFF79A" :foreground "#FFF79A"))))
 '(variable-pitch ((t (:family "Droid Serif")))))
