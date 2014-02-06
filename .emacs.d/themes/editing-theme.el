(deftheme editing
  "Basic editing theme")

(require 'ispell)

(define-keys-globally
  ("<f7>"    . #'ispell-buffer)
  ("M-h"     . #'backward-kill-word)
  ("C-h"     . #'backward-delete-char)
  ("M-j"     . (λ () (interactive) (join-line t)))
  ("C-c C-d" . #'just-one-space)
  ("C-?"     . #'help-command))

;; Undo-tree
(add-user-subdir-to-load-path "external/undo-tree")
(require 'undo-tree)
(define-keys-for-map undo-tree-map
  ("C-z"   . #'undo-tree-undo)
  ("C-S-z" . #'undo-tree-redo)
  ("C-?"   . nil)) ;; Conflicts with global keymap

;; Custom regexp functions
(require 'regexp-tools)

;; Features for basic text
(add-hook 'text-mode-hook 'flyspell-mode)
(add-hook 'text-mode-hook 'visual-line-mode)

;; Logical lines in visual-line-mode
(define-keys visual-line-mode
  ("C-M-a" . #'beginning-of-line)
  ("C-M-e" . #'end-of-line))

(add-hook 'before-save-hook 'delete-trailing-whitespace)


;; File associations

(mapcar (λ (pair)
          (add-to-list 'auto-mode-alist pair))
  '(("[Mm]akefile.*"             . makefile-mode)
    ("\\.\\(ba\\|z\\)sh[^.]*\\'" . sh-mode)))



(custom-theme-set-variables
 'editing
 '(comment-auto-fill-only-comments t)
 '(fill-column 80)
 '(global-undo-tree-mode t)
 '(indent-tabs-mode nil)
 '(show-paren-mode t)
 '(show-paren-delay 0)
 '(standard-indent 8))

(provide-theme 'editing)
