;; Linkify terminal URLs
(add-hook 'term-mode-hook
          'goto-address-mode)

;; Default terminal colors
;(setq term-default-fg-color "#FFFFFF")
(setq term-default-bg-color (frame-parameter nil 'background-color))
(setq term-default-fg-color (frame-parameter nil 'foreground-color))

(if (string< emacs-version "24.3.1")
    (setq ansi-term-color-vector
          [nil term-default-bg-color
               "#F7977A"
               "#3BB878"
               "#FFF79A"
               "#438CCA"
               "#F06EA9"
               "#00FFFF"
               term-default-fg-color]) ; gnome-terminal colors
  (custom-set-faces `(term-color-black   ((t (:background ,term-default-bg-color :foreground ,term-default-bg-color))))
                    '(term-color-red     ((t (:background "#F7977A"              :foreground "#F7977A"))))
                    '(term-color-green   ((t (:background "#3BB878"              :foreground "#3BB878"))))
                    '(term-color-yellow  ((t (:background "#FFF79A"              :foreground "#FFF79A"))))
                    '(term-color-blue    ((t (:background "#438CCA"              :foreground "#438CCA"))))
                    '(term-color-magenta ((t (:background "#F06EA9"              :foreground "#F06EA9"))))
                    '(term-color-cyan    ((t (:background "#00FFFF"              :foreground "#00FFFF"))))
                    `(term-color-white   ((t (:background ,term-default-fg-color :foreground ,term-default-fg-color))))))
;; (setq ansi-term-color-vector
;;       [nil "grey15"
;;            "burlywood1"
;;            "spring green"
;;            "grey80"
;;            "deep sky blue"
;;            "#ff51b3"
;;            "pale turquoise"
;;            "white"])

;; char and line mode
(setq in-char-mode nil)
(setq in-line-mode nil)
(make-variable-buffer-local 'in-char-mode)
(make-variable-buffer-local 'in-line-mode)
(defadvice term-char-mode (after set-char-mode activate)
  (setq in-char-mode t)
  (setq in-line-mode nil))
(defadvice term-line-mode (after set-line-mode activate)
  (setq in-char-mode nil)
  (setq in-line-mode t))
(push '(in-char-mode " char") minor-mode-alist)
(push '(in-line-mode " line") minor-mode-alist)

;; ansi-term keybinds
(defadvice ansi-term (after ansi-term-keybinds activate)
  (local-set-key (kbd "M-h") '(lambda () (interactive) (term-send-raw-string "\e")))
  (local-set-key (kbd "ESC C-t") 'ensure-ansi-term)
  (local-set-key (kbd "M-x") 'execute-extended-command)
  (local-set-key (kbd "M-:") 'eval-expression)
;  (local-set-key (kbd "C-x C-c") 'save-buffers-kill-terminal)
;  (local-set-key (kbd "C-c C-c") 'term-send-raw)
  (local-set-key (kbd "C-[ C-[") '(lambda () (interactive) (term-send-raw-string "\e[2~"))))
(defadvice ansi-term (after ansi-term-unlimited-scrollback activate)
  (setq term-buffer-maximum-size 0))
(defadvice ansi-term (after ansi-term-cleanup activate)
  (let ((term-buffer ad-return-value))
    (set-process-sentinel (get-buffer-process term-buffer)
                          (lambda (proc msg) (kill-buffer (process-buffer proc))))))

;; ansi-term creation
(defun ensure-ansi-term ()
  (interactive)
  (if (get-process "*ansi-term*")
      (switch-to-buffer "*ansi-term*")
    (ansi-term "/bin/bash")
    (switch-to-buffer "*ansi-term*")
    (set-process-query-on-exit-flag (get-process "*ansi-term*") nil)))

(ensure-ansi-term)
(global-set-key (kbd "ESC C-t") 'ensure-ansi-term)
