(defun catch-wrap (forms)
  (if (null forms)
      nil
    `(condition-case nil
         ,(car forms)
       (error
        ,(catch-wrap (cdr forms))))))

(defmacro try-series (&rest forms)
  (catch-wrap forms))

(defun previous-list (&optional arg)
  (interactive "^p")
  (try-series
   (down-list (- 0 arg))
   (backward-list arg)
   (backward-up-list arg)))

(defun next-list (&optional arg)
  (interactive "^p")
  (try-series
   (down-list arg)
   (up-list arg)))

(defun backward-or-up-list (&optional arg)
  (interactive "^p")
  (try-series
   (backward-list arg)
   (backward-up-list arg)))

(defun forward-or-up-list (&optional arg)
  (interactive "^p")
  (try-series
   (forward-list arg)
   (up-list arg)))

(define-minor-mode navigate-parens-mode
  "Used to navigate parenthesis pairs"

  ;; Initial mode value
  nil
  ;; Display in mode line
  t
  ;; Keymap
  `((,(kbd "C-M-b") . backward-or-up-list)
    (,(kbd "C-M-f") . forward-or-up-list)
    (,(kbd "C-M-n") . next-list)
    (,(kbd "C-M-p") . previous-list)))
