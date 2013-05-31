;;; Settings for org-mode

;; Flyspell
(add-hook 'org-mode-hook 'flyspell-mode)

;; Set emacs to open links in `firefox`
(setq browse-url-browser-function 'browse-url-firefox)

;; More convenient insertion of '*' in org-mode
(add-hook 'org-mode-hook
          (lambda () (local-set-key (kbd "C-;") (kbd "*"))))

;; Visual-line mode in org-mode
(add-hook 'org-mode-hook 'visual-line-mode)
