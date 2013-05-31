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

;; Hscroll
(setq hscroll-margin 1)

(defun current-line-length () (interactive)
  (save-excursion (move-end-of-line nil) (current-column)))

(defmacro defmouse-scroll-function (name do-scroll)
  `(defun ,name (event distance)
     (let* ((mouse-position (mouse-position))
            (scroll-window
             (condition-case nil
                 (window-at (cadr mouse-position) (cddr mouse-position)
                            (car mouse-position))
               (error nil)))
            (old-window (selected-window)))
       (select-window scroll-window)
       (,do-scroll distance)
       (select-window old-window))))

(defmouse-scroll-function mouse-scroll-left scroll-left)
(defmouse-scroll-function mouse-scroll-right scroll-right)

(defadvice mouse-scroll-left (around mouse-scroll-left-margin-check activate)
  (let* ((advance (min (ad-get-arg 1)
                       (- (current-line-length) (current-column))))
         (virtual-column (- (current-column) (window-hscroll))))
    (forward-char (max (1+ (- hscroll-margin (- virtual-column advance)))
                       0))
    (ad-set-arg 1 advance)
    ad-do-it))

(defadvice mouse-scroll-right (around mouse-scroll-right-margin-check activate)
  (let* ((advance (min (ad-get-arg 1)
                       (window-hscroll)))
         (virtual-column (- (current-column) (window-hscroll)))
         (edge-distance (- (window-width) virtual-column)))
    (backward-char (max (1+ (- hscroll-margin (- edge-distance advance)))
                        0))
    (ad-set-arg 1 advance)
    ad-do-it))

(global-set-key (kbd "<mouse-6>")        '(lambda (event) (interactive "e") (mouse-scroll-right event 1)))
(global-set-key (kbd "<double-mouse-6>") '(lambda (event) (interactive "e") (mouse-scroll-right event 3)))
(global-set-key (kbd "<triple-mouse-6>") '(lambda (event) (interactive "e") (mouse-scroll-right event 5)))
(global-set-key (kbd "<mouse-7>")        '(lambda (event) (interactive "e") (mouse-scroll-left event 1)))
(global-set-key (kbd "<double-mouse-7>") '(lambda (event) (interactive "e") (mouse-scroll-left event 3)))
(global-set-key (kbd "<triple-mouse-7>") '(lambda (event) (interactive "e") (mouse-scroll-left event 5)))
(global-set-key (kbd "<S-mouse-4>")        '(lambda (event) (interactive "e") (mouse-scroll-right event 1)))
(global-set-key (kbd "S-<double-mouse-4>") '(lambda (event) (interactive "e") (mouse-scroll-right event 3)))
(global-set-key (kbd "S-<triple-mouse-4>") '(lambda (event) (interactive "e") (mouse-scroll-right event 5)))
(global-set-key (kbd "<S-mouse-5>")        '(lambda (event) (interactive "e") (mouse-scroll-left event 1)))
(global-set-key (kbd "S-<double-mouse-5>") '(lambda (event) (interactive "e") (mouse-scroll-left event 3)))
(global-set-key (kbd "S-<triple-mouse-5>") '(lambda (event) (interactive "e") (mouse-scroll-left event 5)))

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
