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
            (add-hook mode-hook 'subword-mode)

            ;; Semantic completion
	    (unless (string< emacs-version "24")
	      (semantic-mode t)
	      (push 'ac-source-semantic ac-sources)))
          mode-hooks))

;; No namespace indentation
(add-to-list 'c++-mode-hook (lambda () (c-set-offset 'innamespace 0)))

;; Associate CUDA source
(add-to-list 'auto-mode-alist
             '("\\.cu" . c++-mode))

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

;; ;; Fix backslash mangling when indenting
;; (defadvice c-indent-line (around indent-backslash-fix activate)
;;   (let* ((line-retrieval-function
;;           (lambda ()
;;             (save-excursion
;;               (let ((bol (progn (beginning-of-line) (point)))
;;                     (eol (progn (end-of-line) (point))))
;;                 (buffer-substring bol eol)))))
;;          (initial-line (funcall line-retrieval-function)))
;;     ad-do-it
;;     (save-excursion
;;       (end-of-line)
;;       (when (equal (char-before) ?\\)
;;         (c-backslash-region
;;          (save-excursion
;;            (beginning-of-line)
;;            (point))
;;          (point)
;;          nil)))
;;     (if (equal (funcall line-retrieval-function) initial-line)
;;         (set-buffer-modified-p nil))))

;; (defadvice c-indent-region (around indent-backslash-fix activate)
;;   (save-excursion
;;     (goto-char (ad-get-arg 0))
;;       (while (<= (point) (ad-get-arg 1))
;;         (c-indent-line)
;;         (forward-line))))

;; (defun regexp-subregions (expr start end)
;;   (save-excursion
;;     (goto-char start)
;;     (save-match-data
;;       (loop while (re-search-forward expr end t) collect
;;             (list (match-beginning 0)
;;                   (match-end 0))))))

;; ;; Replace tabs with spaces before aligned backslashes
;; (defadvice c-backslash-region (around backslash-untabify activate)
;;   (let ((bor (save-excursion (goto-char (ad-get-arg 0)) (beginning-of-line) (point)))
;;         (eor (save-excursion (goto-char (ad-get-arg 1)) (end-of-line) (point))))
;;     ad-do-it
;;     (mapcar (lambda (region) (apply 'untabify region))
;;             (regexp-subregions "[ \t]*\\\\$" bor eor))))
