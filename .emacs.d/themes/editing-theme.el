(deftheme editing
  "Basic editing theme")

(add-user-subdir-to-load-path "external/undo-tree")
(require 'undo-tree)
(global-set-key (kbd "C-z") #'undo-tree-undo)
(global-set-key (kbd "C-S-z") #'undo-tree-redo)

(global-set-key (kbd "M-h") #'backward-kill-word)
(global-set-key (kbd "C-h") #'backward-delete-char)
(global-set-key (kbd "C-?") #'help-command)

(add-hook 'before-save-hook 'delete-trailing-whitespace)

(custom-theme-set-variables
 'editing
 '(indent-tabs-mode nil)
 '(standard-indent 8)
 '(global-undo-tree-mode t)
 '(show-paren-mode t)
 '(show-paren-delay 0))

(provide-theme 'editing)
