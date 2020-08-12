;;; -*- mode: emacs-lisp -*-
;;;
;;; This is an example .emacs file. You can make Emacs more selective about
;;; which themes it loads by modifying `custom-enabled-themes' and
;;; `custom-safe-themes'. Use the command `customize-apropos' with an argument
;;; of "custom-.+-themes" to learn more.

(load-file "~/emacs/prelude.el")

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-enabled-themes *available-themes*)
 '(custom-safe-themes t)
 '(package-selected-packages
   (quote
    (undo-tree smart-tabs-mode slime page-break-lines multiple-cursors magit auto-complete tabbar session pod-mode muttrc-mode mutt-alias markdown-mode initsplit htmlize graphviz-dot-mode folding eproject diminish csv-mode color-theme-modern browse-kill-ring boxquote bm bar-cursor apache-mode auctex)))
 '(page-break-lines-char 45)
 '(safe-local-variable-values (quote ((eval c-set-offset (quote case-label) (quote +))))))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
