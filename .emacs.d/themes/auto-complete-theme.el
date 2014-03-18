(deftheme auto-complete
  "Settings for auto-complete")

(require 'auto-complete)

(define-keys-for-map ac-complete-mode-map
  (make-alist
   '(("\r"         . nil)
     ("<return>"   . nil)
     ("<C-return>" . #'ac-complete)
     ("M-n"        . #'ac-next)
     ("M-p"        . #'ac-previous))))



(custom-theme-set-variables
 'auto-complete
; '(ac-auto-show-menu 0.0)
 '(ac-auto-start 0)
 '(ac-delay 0.0)
 '(ac-ignore-case nil)
 '(global-auto-complete-mode t))

(provide-theme 'auto-complete)
