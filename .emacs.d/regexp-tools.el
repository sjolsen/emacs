(defun collect-matches-to-kill-ring (regexp &optional start end)
  "Collects matches of REGEXP into a list and pushes that list onto the kill ring"
  (interactive "MRegexp to match: \nr")
  (save-excursion
    (save-match-data
      (goto-char start)
      (let* ((region-string  (buffer-substring-no-properties start end))
             (submatch-start 0)
             (submatch-end   0)
             (matches
              (loop while (string-match regexp region-string submatch-end) collect
                    (progn
                      (setq submatch-start (match-beginning 0) submatch-end (match-end 0))
                      (substring region-string submatch-start submatch-end)))))
        (kill-new (prin1-to-string matches))))))
