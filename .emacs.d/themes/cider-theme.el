(deftheme cider
  "Settings for cider")

(require 'cider-test-mode)

(defun cider-jump-other-window (query)
  "Jump to the definition of QUERY in another window."
  (interactive "P")
  (let ((repl-buffer (current-buffer))
        (def-buffer
          (progn
            (cider-read-symbol-name "Symbol: " 'cider-jump-to-def query)
            (current-buffer))))
    (switch-to-buffer repl-buffer)
    (switch-to-buffer-other-window def-buffer)))

(define-keys cider-repl-mode
  ("M-." .      #'cider-jump-other-window)
  ("<return>" . nil))

(provide-theme 'cider)
