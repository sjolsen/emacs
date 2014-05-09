(deftheme brown
  "Brown.")

(custom-theme-set-faces
 'brown
 '(custom-state                 ((((type x)) (:foreground "lemon chiffon"))))
 '(default                      ((((type x)) (:foreground "grey" :background "#29211E"))))
 '(error                        ((((type x)) (:foreground "firebrick"))))
 '(font-lock-builtin-face       ((((type x)) (:foreground "light blue"))))
 '(font-lock-comment-face       ((((type x)) (:foreground "cornsilk3"))))
 '(font-lock-constant-face      ((((type x)) (:foreground "sky blue"))))
 '(font-lock-function-name-face ((((type x)) (:foreground "#fefecf" :inherit bold))))
 '(font-lock-keyword-face       ((((type x)) (:foreground "azure1" :inherit bold))))
 '(font-lock-string-face        ((((type x)) (:foreground "white"))))
 '(font-lock-type-face          ((((type x)) (:foreground "#b5d18a"))))
 '(font-lock-variable-name-face ((((type x)) (:foreground "cornsilk" :inherit bold))))
; '(highlight                    ((((type x)) (:foreground "cornsilk" :background "#39312E" :underline ((type x))))))
 '(highlight                    ((((type x)) (:foreground "cornsilk" :background nil :underline t))))
 '(isearch                      ((((type x)) (:foreground "sienna" :background "lemonchiffon"))))
 '(lazy-highlight               ((((type x)) (:background "burlywood4"))))
 '(mode-line                    ((((type x)) (:foreground "black" :background "grey75" :inverse-video nil :box nil))))
 '(region                       ((((type x)) (:background "grey22"))))
 '(warning                      ((((type x)) (:foreground "darkorange1" :bold nil))))
 '(widget-field                 ((((type x)) (:background "grey20")))))

(provide-theme 'brown)
