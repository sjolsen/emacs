;;; -*- lexical-binding: t -*-

(deftheme cc-settings
  "Settings for C, C++, and more")

(defvar cc-map/hook-alist
  '((c-mode-map   . c-mode-hook)
    (c++-mode-map . c++-mode-hook))
  "Modes to which we're going to add common key customizations. This
should be an alist mapping mode-map names to mode-hook names.")

(defvar cc-keybind-alist
  '(("C-m" . #'c-context-line-break))
  "An alist mapping forms which evaluate to suitable arguments to
`read-kbd-macro' to forms which evaluate to commands")

(defun hook-up-cc-keybinds ()
  (let ((binding-alist (make-alist cc-keybind-alist)))
    (dolist (map/hook cc-map/hook-alist)
      (let ((mode-map-sym (car map/hook))
            (mode-hook-sym (cdr map/hook)))
        (add-hook mode-hook-sym (λ ()
                                  (dolist (binding binding-alist)
                                    (define-key (eval mode-map-sym)
                                      (read-kbd-macro (car binding))
                                      (cdr binding)))))))))

(eval-after-load 'cc-mode
  (hook-up-cc-keybinds))


;; Smarttabs settings

(eval-after-load 'cc-mode
  '(progn
     (require 'smart-tabs-mode)
     (smart-tabs-insinuate 'c 'c++)))


;; Auto-complete settings

(defvar *cc-mode-ac-sources*
  '(ac-source-clang))

(defvar *clang-get-driver-parameters-command*
  "clang++ '-###' -x c++ - 2>&1")

(defun clang-include-flags ()
  (let* ((raw-output (shell-command-to-string *clang-get-driver-parameters-command*))
         (paths (collect-matches "\"[^ ]*?include[^ ]*?\"" raw-output)))
    (mapcar (λ (path)
              (concat "-I" (substring path 1 (- (length path) 1))))
            paths)))

(add-hook 'c-mode-common-hook (λ ()
                                (when (featurep 'auto-complete)
                                  (require 'auto-complete-clang)
                                  (setq ac-clang-flags (append (clang-include-flags) ac-clang-flags))
                                  (setq ac-sources *cc-mode-ac-sources*))))



(custom-theme-set-variables
 'cc-settings
 '(c-auto-align-backslashes nil)
 '(c-cleanup-list (quote (scope-operator)))
 '(c-default-style (quote ((c-mode . "bsd") (c++-mode . "bsd") (java-mode . "java") (awk-mode . "awk") (other . "gnu"))))
 '(c-doc-comment-style (quote ((c-mode . gtkdoc) (c++-mode . javadoc) (java-mode . javadoc) (pike-mode . autodoc))))
 '(c-offsets-alist (quote ((cpp-define-intro . 0) (cpp-macro . 0)))))

(custom-theme-set-faces
 'cc-settings
 )

(provide-theme 'cc-settings)
