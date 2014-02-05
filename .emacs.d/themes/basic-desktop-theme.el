(deftheme basic-desktop
  "Basic settings for desktop use of Emacs")

(add-user-subdir-to-load-path "external/")
(require 'page-break-lines)

(defun save-buffers-kill-for-clients (ARG)
  "Closes Emacs. If running in client mode, don't kill the server, but kill the
client instead. Use prefix argument to kill the server, too."
  (interactive "P")
  (if ARG
      (save-buffers-kill-emacs)
    (save-buffers-kill-terminal)))

(defun kill-other-buffer-and-window (&optional COUNT)
  "Like `kill-buffer-and-window' (C-x 4 0), but gets rid of the other window and
its buffer. This is particularly useful for getting rid of obnoxious help
windows and the like."
  (interactive)
  (save-excursion
    (other-window (or COUNT 1))
    (kill-buffer-and-window)))

(require 'hscroll)
(define-keys-globally
  ("<mouse-6>"          . (λ (event) (interactive "e") (mouse-scroll-right event 1)))
  ("<double-mouse-6>"   . (λ (event) (interactive "e") (mouse-scroll-right event 3)))
  ("<triple-mouse-6>"   . (λ (event) (interactive "e") (mouse-scroll-right event 5)))
  ("<mouse-7>"          . (λ (event) (interactive "e") (mouse-scroll-left  event 1)))
  ("<double-mouse-7>"   . (λ (event) (interactive "e") (mouse-scroll-left  event 3)))
  ("<triple-mouse-7>"   . (λ (event) (interactive "e") (mouse-scroll-left  event 5)))
  ("S-<mouse-4>"        . (λ (event) (interactive "e") (mouse-scroll-right event 1)))
  ("S-<double-mouse-4>" . (λ (event) (interactive "e") (mouse-scroll-right event 3)))
  ("S-<triple-mouse-4>" . (λ (event) (interactive "e") (mouse-scroll-right event 5)))
  ("S-<mouse-5>"        . (λ (event) (interactive "e") (mouse-scroll-left  event 1)))
  ("S-<double-mouse-5>" . (λ (event) (interactive "e") (mouse-scroll-left  event 3)))
  ("S-<triple-mouse-5>" . (λ (event) (interactive "e") (mouse-scroll-left  event 5))))

(define-keys-globally
  ("<C-M-prior>"   . #'backward-page)
  ("<C-M-next>"    . #'forward-page)
  ("<C-M-up>"      . #'windmove-up)
  ("<C-M-down>"    . #'windmove-down)
  ("<C-M-left>"    . #'windmove-left)
  ("<C-M-right>"   . #'windmove-right)
  ("<Scroll_Lock>" . #'scroll-lock-mode)
  ("C-x 4 1"       . #'kill-other-buffer-and-window)
  ("C-x C-c"       . #'save-buffers-kill-for-clients)
  ("C-x C-b"       . #'ibuffer-list-buffers))



(custom-theme-set-variables
 'basic-desktop
 '(enable-recursive-minibuffers t)
 '(column-number-mode t)
 '(current-language-environment "UTF-8")
 '(default-frame-alist (quote ((width . 120)
                               (height . 50)
                               (alpha 95 95))))
 '(global-page-break-lines-mode t)
 '(hscroll-margin 1)
 '(inhibit-startup-screen t)
 '(minibuffer-depth-indicate-mode t)
 '(page-break-lines-char 45)
 '(tool-bar-mode nil)
 '(truncate-lines t))

(provide-theme 'basic-desktop)
