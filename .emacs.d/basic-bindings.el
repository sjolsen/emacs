;;; Basic keyboard and mouse bindings

(defalias 'λ 'lambda)
(font-lock-add-keywords 'emacs-lisp-mode
                        '(("λ" . font-lock-keyword-face)))

(require 'define-keys)

;; Logical lines in visual-line-mode
(define-keys visual-line-mode
  ("C-M-a" . #'beginning-of-line)
  ("C-M-e" . #'end-of-line))

;; Elements in nXML
(define-keys nxml-mode
  ("C-M-a"   . #'nxml-backward-element)
  ("C-M-e"   . #'nxml-forward-element)
  ("M-h"     . #'backward-kill-word)
  ("C-c C-c" . #'comment-region))

;; Auto-indent in HTML
(define-keys html-mode
  ("<return>" . #'newline-and-indent))

;; Code folding
(define-keys hs-minor-mode
  ("<C-tab>"   . #'hs-toggle-hiding)
  ("<C-M-tab>" . #'hs-hide-level))

;; Super-kill
(global-set-key (kbd "C-x C-c")
  (λ (ARG)
    (interactive "P")
    (if ARG
        (save-buffers-kill-emacs)
      (save-buffers-kill-terminal))))

;; ibuffer
(global-set-key (kbd "C-x C-b") #'ibuffer-list-buffers)

;; Symbol replace
(defun replace-symbol (old-symbol new-symbol &optional start end)
  (interactive
   (let ((common
	  (query-replace-read-args
	   (concat "Replace"
		   (if current-prefix-arg " word" "")
		   " symbol"
		   (if (and transient-mark-mode mark-active) " in region" ""))
	   t)))
     (list (nth 0 common) (nth 1 common)
	   (if (and transient-mark-mode mark-active)
	       (region-beginning))
	   (if (and transient-mark-mode mark-active)
	       (region-end)))))
  (replace-regexp (concat "\\_<" old-symbol "\\_>")
                  new-symbol nil start end))

;; Associate .bashrc files
(add-to-list 'auto-mode-alist '("\\.\\(ba\\|z\\)sh[^.]*\\'" . sh-mode))

;; Global forward and back
(global-set-key (kbd "<mouse-8>") 'previous-buffer)
(global-set-key (kbd "<mouse-9>") 'next-buffer)

;; Enable recursive minibuffer
(setq enable-recursive-minibuffers t)
(minibuffer-depth-indicate-mode)

;; Right margin
(defun get-right-margin ()
  (- (window-width (selected-window)) 1))

;; Fill column
(setq-default fill-column 80)

;; Mouse history in Info-mode
(define-keys Info-mode-map 'Info-mode
  ("<mouse-8>" #'Info-history-back)
  ("<mouse-9>" #'Info-history-forward))

;; Tab-completion in eval-expression
(add-hook 'minibuffer-setup-hook
          (λ ()
            (if (eq this-command 'eval-expression)
                (local-set-key (kbd "TAB") 'lisp-complete-symbol))))

;; Page break navigation
(global-set-key (kbd "<C-M-prior>") 'backward-page)
(global-set-key (kbd "<C-M-next>") 'forward-page)

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
                (λ () (interactive)
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
(require 'cc-mode)
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
