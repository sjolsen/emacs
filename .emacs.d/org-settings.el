;;; Settings for org-mode

;; Flyspell
(add-hook 'org-mode-hook 'flyspell-mode)

;; Set emacs to open links in `firefox`
(setq browse-url-browser-function 'browse-url-firefox)

(add-hook 'org-mode-hook
          (lambda ()
            ;; More convenient insertion of '*' in org-mode
            (local-set-key (kbd "C-;") (kbd "*"))
            ;; M-h
            (local-set-key (kbd "M-h") 'backward-kill-word)))

;; Visual-line mode in org-mode
(add-hook 'org-mode-hook 'visual-line-mode)
