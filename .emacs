(add-to-list 'load-path "~/.emacs.d/")



(load "basic-bindings")
(load "c-c++-settings")
(load "hscroll")
(load "lisp-settings")
(load "org-settings")
(load "visual-settings")
(load "term-settings")
(if (file-exists-p "~/Documents/configs/rcirc-settings.el")
    (load-file "~/Documents/configs/rcirc-settings.el"))

;; Multiple cursors
(add-to-list 'load-path "~/.emacs.d/multiple-cursors")
(require 'multiple-cursors)

;; auto-complete
(require 'auto-complete-config)
(add-to-list 'ac-dictionary-directories "~/.emacs.d//ac-dict")
(ac-config-default)
(setq ac-ignore-case nil)
(add-hook 'auto-complete-mode-hook
          (lambda ()
            (define-key ac-completing-map (kbd "RET") nil)
            (define-key ac-completing-map (kbd "<C-return>") 'ac-complete)))
(add-hook 'auto-complete-mode-hook (lambda () (local-set-key (kbd "C-n") 'next-line)))
(add-hook 'auto-complete-mode-hook (lambda () (local-set-key (kbd "<down>") 'next-line)))
(add-hook 'auto-complete-mode-hook (lambda () (local-set-key (kbd "C-p") 'previous-line)))
(add-hook 'auto-complete-mode-hook (lambda () (local-set-key (kbd "<up>") 'previous-line)))

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
(global-page-break-lines-mode 1)

;; Undo Tree
(add-to-list 'load-path "~/.emacs.d/undo-tree")
(require 'undo-tree)
(global-undo-tree-mode)

;; Flex and Bison
;; (load "flex-mode")
;; (load "bison-mode")
;; (add-to-list 'auto-mode-alist '("\\.y$" . bison-mode))
;; (add-to-list 'auto-mode-alist '("\\.l$" . flex-mode))



(custom-set-variables
  ;; custom-set-variables was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(column-number-mode t)
 '(font-use-system-font t)
 '(inhibit-startup-screen t)
 '(mouse-wheel-scroll-amount (quote (1 ((control)))))
 '(page-break-lines-char 45)
 '(tool-bar-mode nil)
 '(truncate-lines t))
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
 '(variable-pitch ((t (:family "Droid Serif")))))
