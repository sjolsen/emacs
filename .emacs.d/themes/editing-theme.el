(deftheme editing
  "Basic editing theme")

(add-user-subdir-to-load-path "external/undo-tree")
(require 'undo-tree)
(define-keys-for-map undo-tree-map
  ("C-z"   . #'undo-tree-undo)
  ("C-S-z" . #'undo-tree-redo)
  ("C-?"   . nil))

(define-keys-globally
  ("M-h" . #'backward-kill-word)
  ("C-h" . #'backward-delete-char)
  ("C-?" . #'help-command))

(add-hook 'before-save-hook 'delete-trailing-whitespace)

(custom-theme-set-variables
 'editing
 '(indent-tabs-mode nil)
 '(standard-indent 8)
 '(global-undo-tree-mode t)
 '(show-paren-mode t)
 '(show-paren-delay 0))

(provide-theme 'editing)
