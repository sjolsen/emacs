;;; C/C++ Customization

;; Use trunk cc-mode
(add-to-list 'load-path "~/.emacs.d/cc-mode")
(require 'cc-mode)

;; No extra macro indentation
(c-set-offset 'cpp-define-intro 0 nil)

;; Fill column
;; (setq-default c-backslash-column 80)
;; (setq-default c-backslash-max-column 80)
;; (make-local-variable 'c-backslash-max-column)
;; (add-hook 'window-configuration-change-hook
;;           (lambda () (setq c-backslash-max-column (get-right-margin))))

;; Pull backslashes back to the end of the line
(defun canonicalize-backslashes (start end)
  (interactive "r")
  (let ((tab-regexp "\\(^\\| \\)\\([[:space:]]+\\)\\\\$"))
    (save-excursion
      (goto-char start)
      (save-match-data
        (loop while (re-search-forward tab-regexp end t) do
              (let* ((current-match-start (match-beginning 2))
                     (current-match-end   (match-end 2))
                     (original-size       (- current-match-end current-match-start)))
                (delete-region current-match-start current-match-end)
                (let ((current-size (- (point) current-match-start)))
                  (setq end (+ end (- current-size original-size))))))))))

(defface c-backslash-face
  '((default . (:foreground "dim gray")))
  "Face for displaying terminal backslashes in C and related modes")

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

            ;; Spell checking for comments
            ;; (add-hook mode-hook
            ;;           (lambda ()
            ;;             (require 'flyspell)
            ;;             (require 'ispell)
            ;;             (flyspell-prog-mode)
            ;;             (local-set-key (kbd "<f7>") (λ () (interactive) (ispell-comments-and-strings nil)))))

            ;; Auto-complete
            (add-hook mode-hook
                      (lambda ()
                        (setq ac-sources (append '(ac-source-gtags) ac-sources))
                        (if (executable-find "clang")
                            (setq ac-sources (append '(ac-source-clang) ac-sources)))))

            ;; Yasnippet
            (add-hook mode-hook 'yas-minor-mode)

            ;; List navigation
            (add-hook mode-hook 'navigate-parens-mode)

            ;; Fix any errant backslashes
            (add-hook mode-hook
              (λ ()
                (setq write-contents-functions
                      (cons (λ () (canonicalize-backslashes 0 (buffer-size)))
                            write-contents-functions))

                ; Give backslashes a less intrusive appearance
                (font-lock-add-keywords nil
                                        '(("\\(\\\\\\)$" 1 'c-backslash-face)))))

            ;; URL navigation
            (add-hook mode-hook #'goto-address-mode)

            ;; Fill column indicator
            ;(add-hook mode-hook 'fci-mode)

            ;; Semantic completion
	    ;(unless (string< emacs-version "24")
	    ;  (semantic-mode t)
	    ;  (push 'ac-source-semantic ac-sources))

            ;; Code folding
            (add-hook mode-hook #'hs-minor-mode))
          mode-hooks))

;; Automatic parens
;; (electric-pair-mode 1)
;; (defun insert-angle-brackets (&optional arg)
;;   (interactive "P")
;;   (insert-pair arg ?< ?>))
;; (add-hook 'c++-mode-hook
;;           (lambda ()
;;             (local-set-key (kbd "C-,") 'insert-angle-brackets)))

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
(add-to-list 'load-path "~/.emacs.d/elpa/cl-lib-0.3")
(add-to-list 'load-path "~/.emacs.d/smarttabs")
(require 'smart-tabs-mode)
(add-hook 'c-mode-hook 'smart-tabs-mode-enable)
(add-hook 'c++-mode-hook 'smart-tabs-mode-enable)
(smart-tabs-advice c-indent-line c-basic-offset)
(smart-tabs-advice c-indent-region c-basic-offset)

;; Improved font-locking for C++11
(add-hook
 'c++-mode-hook
 '(lambda()
    ;; We could place some regexes into `c-mode-common-hook', but note that their evaluation order
    ;; matters.
    (font-lock-add-keywords
     nil '(;; complete some fundamental keywords
           ("\\<\\(void\\|unsigned\\|signed\\|char\\|short\\|bool\\|int\\|long\\|float\\|double\\)\\>" . font-lock-keyword-face)
           ;; namespace names and tags - these are rendered as constants by cc-mode
           ;("\\<\\(\\w+::\\)" . font-lock-function-name-face)
           ;;  new C++11 keywords
           ("\\<\\(alignof\\|alignas\\|constexpr\\|decltype\\|noexcept\\|nullptr\\|static_assert\\|thread_local\\|override\\|final\\)\\>" . font-lock-keyword-face)
           ("\\<\\(char16_t\\|char32_t\\)\\>" . font-lock-keyword-face)
           ;; PREPROCESSOR_CONSTANT, PREPROCESSORCONSTANT
           ;("\\<[A-Z]*_[A-Z_]+\\>" . font-lock-constant-face)
           ;("\\<[A-Z]\\{3,\\}\\>"  . font-lock-constant-face)
           ;; hexadecimal/binary literals
           ("\\<0[xXbB][0-9A-Fa-f]+\\>" . font-lock-constant-face)
           ;; integer/float/scientific numbers
           ("\\<[\\-+]*[0-9]*\\.?[0-9]+\\([ulUL]+\\|[eE][\\-+]?[0-9]+\\)?\\w*\\>" . font-lock-constant-face)
           ;; c++11 string literals
           ;;       L"wide string"
           ;;       L"wide string with UNICODE codepoint: \u2018"
           ;;       u8"UTF-8 string", u"UTF-16 string", U"UTF-32 string"
           ("\\<\\([LuU8]+\\)\".*?\"" 1 font-lock-keyword-face)
           ;;       R"(user-defined literal)"
           ;;       R"( a "quot'd" string )"
           ;;       R"delimiter(The String Data" )delimiter"
           ;;       R"delimiter((a-z))delimiter" is equivalent to "(a-z)"
           ("\\(\\<[uU8]*R\"[^\\s-\\\\()]\\{0,16\\}(\\)" 1 font-lock-keyword-face t) ; start delimiter
           (   "\\<[uU8]*R\"[^\\s-\\\\()]\\{0,16\\}(\\(.*?\\))[^\\s-\\\\()]\\{0,16\\}\"" 1 font-lock-string-face t)  ; actual string
           (   "\\<[uU8]*R\"[^\\s-\\\\()]\\{0,16\\}(.*?\\()[^\\s-\\\\()]\\{0,16\\}\"\\)" 1 font-lock-keyword-face t) ; end delimiter

           ;; user-defined types (rather project-specific)
           ("\\<[A-Za-z_]+[A-Za-z_0-9]*_\\(t\\|type\\|ptr\\)\\>" . font-lock-type-face)
           ))
    ) t)

;; filter annoying messages
(defvar message-filter-regexp-list '("clang failed with error 1")
  "filter formatted message string to remove noisy messages")
(defadvice message (around message-filter-by-regexp activate)
  (if (not (ad-get-arg 0))
      ad-do-it
    (let ((formatted-string (apply 'format (ad-get-args 0))))
      (if (and (stringp formatted-string)
               (some (lambda (re) (string-match re formatted-string)) message-filter-regexp-list))
          (save-excursion
            (set-buffer "*Messages*")
            (goto-char (point-max))
            (insert formatted-string "\n"))
        (progn
          (ad-set-args 0 `("%s" ,formatted-string))
          ad-do-it)))))
