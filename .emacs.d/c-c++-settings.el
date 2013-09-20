;;; C/C++ Customization

;; No extra macro indentation
(c-set-offset 'cpp-define-intro 0 nil)

;; Fill column
(setq c-backslash-column 80)
(make-local-variable 'c-backslash-max-column)
(add-hook 'window-configuration-change-hook
          (lambda () (setq c-backslash-max-column (get-right-margin))))

(let ((mode-hooks '(c-mode-hook c++-mode-hook)))
  (mapcar (lambda (mode-hook)
            ;; Join lines
            (add-hook mode-hook
                      (lambda ()
                        (local-set-key (kbd "M-j")
                                       (lambda () (interactive)
                                         (join-line -1)))))

            ;; Indent CPP directives
            (add-hook mode-hook
                      (lambda () (c-set-offset 'cpp-macro 0)))

            ;; Auto-indent on newline
            (add-hook mode-hook
                      (lambda () (local-set-key (kbd "C-m")
                                                'c-context-line-break)))

            ;; Subword-mode
            (if (fboundp 'subword-mode)
                (add-hook mode-hook 'subword-mode))

            ;; Semantic completion
	    (unless (string< emacs-version "24")
	      (semantic-mode t)
	      (push 'ac-source-semantic ac-sources)))
          mode-hooks))

;; No namespace indentation
(add-to-list 'c++-mode-hook (lambda () (c-set-offset 'innamespace 0)))

;; Associate MIC source
(add-to-list 'auto-mode-alist
             '("\\.mic\\(c\\|h\\)" . c++-mode))

;; Associate CUDA source
(add-to-list 'auto-mode-alist
             '("\\.cu\\(hh\\)?" . c++-mode))

;; Associate .thh and .tcc file
(add-to-list 'auto-mode-alist
             '("\\.t\\(hh\\|cc\\)\\'" . c++-mode))

;; Indentation style
(setq c-default-style "bsd")

;; Smart tabs
(setq-default tab-width 8)
(add-to-list 'load-path "~/.emacs.d/smarttabs")
(require 'smart-tabs-mode)
(add-hook 'c-mode-hook 'smart-tabs-mode-enable)
(add-hook 'c++-mode-hook 'smart-tabs-mode-enable)
(smart-tabs-advice c-indent-line c-basic-offset)
(smart-tabs-advice c-indent-region c-basic-offset)

;; Replace tabs with spaces before aligned backslashes
(defun untabify-backslashes (start end)
  (interactive "r")
  (let ((tab-regexp "[ \t]*\\\\$"))
    (save-excursion
      (goto-char start)
      (save-match-data
        (loop while (re-search-forward tab-regexp end t) do
              (let* ((current-match-start (match-beginning 0))
                     (current-match-end   (match-end 0))
                     (original-size       (- current-match-end current-match-start)))
                (untabify current-match-start current-match-end)
                (let ((current-size (- (point) current-match-start)))
                  (setq end (+ end (- current-size original-size))))))))))
