;;; C/C++ Customization

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
                                                'newline-and-indent)))

            ;; Subword-mode
            (add-hook mode-hook 'subword-mode))
          mode-hooks))

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
(setq cua-auto-tabify-rectangles nil)

(defadvice align (around smart-tabs activate)
(let ((indent-tabs-mode nil)) ad-do-it))

(defadvice align-regexp (around smart-tabs activate)
(let ((indent-tabs-mode nil)) ad-do-it))

(defadvice indent-relative (around smart-tabs activate)
(let ((indent-tabs-mode nil)) ad-do-it))

(defadvice indent-according-to-mode (around smart-tabs activate)
(let ((indent-tabs-mode indent-tabs-mode))
(if (memq indent-line-function
          '(indent-relative
            indent-relative-maybe))
    (setq indent-tabs-mode nil))
ad-do-it))

(defmacro smart-tabs-advice (function offset)
`(progn
 (defvaralias ',offset 'tab-width)
 (defadvice ,function (around smart-tabs activate)
   (cond
    (indent-tabs-mode
     (save-excursion
       (beginning-of-line)
       (while (looking-at "\t*\\( +\\)\t+")
         (replace-match "" nil nil nil 1)))
     (setq tab-width tab-width)
     (let ((tab-width fill-column)
           (,offset fill-column)
           (wstart (window-start)))
       (unwind-protect
           (progn ad-do-it)
         (set-window-start (selected-window) wstart))))
    (t
     ad-do-it)))))

(smart-tabs-advice c-indent-line c-basic-offset)
(smart-tabs-advice c-indent-region c-basic-offset)
