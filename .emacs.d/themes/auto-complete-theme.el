(deftheme auto-complete
  "Settings for auto-complete")

(require 'auto-complete)

(define-keys-for-map ac-complete-mode-map
  (make-alist
   '(("<return>" . nil)
     ("\r"       . nil)
     ("C-n"      . #'ac-next)
     ("C-p"      . #'ac-previous)
     ("M-n"      . #'ac-quick-help-scroll-down)
     ("M-p"      . #'ac-quick-help-scroll-up))))



(custom-theme-set-variables
 'auto-complete
 '(ac-auto-show-menu 0.0)
 '(ac-auto-start 0)
 '(ac-delay 0.0)
 '(ac-ignore-case nil)
 '(global-auto-complete-mode t))

(provide-theme 'auto-complete)
