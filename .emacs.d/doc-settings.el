;; Middle-mouse for info-mode
(add-hook 'Info-mode-hook
          (local-set-key (kbd "<mouse-2>") (lambda () (interactive) (Info-follow-nearest-node t))))
