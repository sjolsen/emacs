;;; regexp-tools.el --- Custom functions for manipulating text by regexp

(defun collect-matches (regexp string &optional group)
  (save-match-data
    (let ((group (or group 0))
          (submatch-start   0)
          (submatch-end     0)
          (case-fold-search nil))
      (loop while (string-match regexp string submatch-end) collect
            (progn
              (setq submatch-start (match-beginning group) submatch-end (match-end group))
              (substring string submatch-start submatch-end))))))

(defun collect-matches-to-kill-ring (regexp &optional start end)
  "Collects matches of REGEXP into a list and pushes that list onto the kill ring"
  (interactive "MRegexp to match: \nr")
  (save-excursion
    (goto-char start)
      (let* ((region-string (buffer-substring-no-properties start end))
             (matches (collect-matches regexp region-string)))
        (kill-new (prin1-to-string matches)))))

(defun replace-symbol (old-symbol new-symbol &optional start end)
  "Performs the specified symbol replacement within the given region.
This function is essentially a restricted form of `replace-string'; the primary
difference is that it will only replace occurences which lie between symbol
boundaries. This allows, for example, the programmatic replacement of the
identifier `the' without modifying occurences of the identifier `theory'."
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

(provide 'regexp-tools)
