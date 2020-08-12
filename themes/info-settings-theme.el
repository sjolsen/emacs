(deftheme info-settings
  "Settings for Info")

(autoload 'info "info")
(eval-after-load "info"
  '(define-keys Info-mode
     ("<mouse-8>" . #'Info-history-back)
     ("<mouse-9>" . #'Info-history-forward)))



(provide-theme 'info-settings)
