;;; Basic keyboard and mouse bindings

;; Page break navigation
(global-set-key (kbd "<C-M-prior>") 'backward-page)
(global-set-key (kbd "<C-M-next>") 'forward-page)

;; M-h in nxml-mode
(add-hook 'nxml-mode-hook
          (lambda ()
            (local-set-key (kbd "M-h") 'backward-kill-word)))

;; Auto-indent in HTML
(add-hook 'html-mode-hook
          (lambda ()
            (local-set-key (kbd "<return>") 'newline-and-indent)))

;; Undo
(global-set-key (kbd "C-z") 'undo)

;; Rectangle copy
(if (not (boundp 'copy-rectangle-as-kill))
    (defun copy-rectangle-as-kill (start end)
      (interactive "r")
      (setq killed-rectangle (extract-rectangle start end))
      (deactivate-mark)))
(global-set-key (kbd "C-x r M-w") 'copy-rectangle-as-kill)

;; Spell-check
(global-set-key (kbd "<f7>") 'ispell-buffer)
(add-hook 'text-mode-hook 'flyspell-mode)
(add-hook 'text-mode-hook 'visual-line-mode)

;; Disable suspend-frame
(defadvice suspend-frame (around disable-suspend-frame activate))

;; Kill other buffer and window
(defun kill-other-buffer-and-window (COUNT)
  (save-excursion
    (other-window COUNT)
    (kill-buffer-and-window)))

(global-set-key (kbd "C-x 4 1")
                (lambda () (interactive)
                  (kill-other-buffer-and-window 1)))


;; Scrolling
(global-set-key (kbd "<f12>") 'scroll-lock-mode)

;; Eval and replace
(defun eval-and-replace ()
  "Replace the preceding sexp with its value."
  (interactive)
  (backward-kill-sexp)
  (prin1 (eval (read (current-kill 0)))
         (current-buffer)))
(global-set-key (kbd "C-c e") 'eval-and-replace)

;; Keyboard scrolling
(global-set-key (kbd "<Scroll_Lock>") 'scroll-lock-mode)

;; Bind hungry-delete globally
(global-set-key (kbd "C-c C-d") 'c-hungry-delete-forward)

;; Add goto
(local-set-key (kbd "M-l") 'goto-line)
(defun goto (&optional line col)
  "Go to the specified line and column"
  (interactive "nline: \nncol: ")
  (if line (goto-line line))
  (if col (move-to-column col)))

;; Backspacing
(global-set-key (kbd "C-?") 'help-command)
(global-set-key (kbd "M-?") 'mark-paragraph)
(global-set-key (kbd "C-h") 'delete-backward-char)
(global-set-key (kbd "M-h") 'backward-kill-word)

;; Remove trailing whitespace on save:
(add-hook 'before-save-hook 'delete-trailing-whitespace)
