;; Linkify terminal URLs
(add-hook 'term-mode-hook
          'goto-address-mode)

;; Default terminal colors
(setq term-default-bg-color nil)
(setq term-default-fg-color nil)
;; (setq term-default-bg-color (frame-parameter nil 'background-color))
;; (setq term-default-fg-color (frame-parameter nil 'foreground-color))

;; Use  and  for output suppression
(setq ansi-term-suppress-output nil)
(make-local-variable 'ansi-term-suppress-output)
(defun ansi-term-suppression (str)
  (unless (string= str "")
    (save-match-data
      (let ((ctrl-char-index (string-match "[]" str)))
        (if (null ctrl-char-index)
            (if ansi-term-suppress-output "" str)
          (let ((output ""))
            (unless ansi-term-suppress-output
              (setq output (substring str 0 ctrl-char-index)))
            (if (char-equal (aref str ctrl-char-index) ?)
                (setq ansi-term-suppress-output t)
              (setq ansi-term-suppress-output nil))
            (concat output (ansi-term-suppression (substring str (1+ ctrl-char-index))))))))))

(defadvice term-emulate-terminal (before enact-suppression (proc str) activate)
  (setq str (ansi-term-suppression str)))

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
  (local-set-key (kbd "M-h") (lambda () (interactive) (term-send-raw-string "\e")))
  (local-set-key (kbd "ESC C-t") 'ensure-ansi-term)
  (local-set-key (kbd "M-x") 'execute-extended-command)
  (local-set-key (kbd "M-:") 'eval-expression)
  ; <backtab>
  (local-set-key (kbd "<backtab>") (lambda () (interactive) (term-send-raw-string "[Z")))
  (local-set-key (kbd "C-c C-q") (lambda () (interactive) (setq ansi-term-suppress-output nil)))
  ; Copy/Paste
  (local-set-key (kbd "C-S-c") 'kill-ring-save)
  (local-set-key (kbd "C-S-v") 'term-paste)
  ; Quoted insert
;  (local-set-key (kbd "C-u") 'universal-argument)
  (local-set-key (kbd "C-q")
    (lambda (ARG)
      (interactive "p")
      (term-send-raw-string
       (make-string ARG (read-quoted-char)))))
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
    (ansi-term (getenv "SHELL"))
    (switch-to-buffer "*ansi-term*")
    (set-process-query-on-exit-flag (get-process "*ansi-term*") nil)))



(ensure-ansi-term)
(global-set-key (kbd "ESC C-t") 'ensure-ansi-term)
