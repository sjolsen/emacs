(deftheme brown
  "Brown.")

(custom-theme-set-faces
 'brown
 '(custom-state                 ((t (:foreground "lemon chiffon"))))
 '(default                      ((t (:foreground "grey" :background "#29211E"))))
 '(error                        ((t (:foreground "firebrick"))))
 '(font-lock-builtin-face       ((t (:foreground "light blue"))))
 '(font-lock-comment-face       ((t (:foreground "cornsilk3"))))
 '(font-lock-constant-face      ((t (:foreground "sky blue"))))
 '(font-lock-function-name-face ((t (:foreground "#fefecf" :inherit bold))))
 '(font-lock-keyword-face       ((t (:foreground "azure1" :inherit bold))))
 '(font-lock-string-face        ((t (:foreground "white"))))
 '(font-lock-type-face          ((t (:foreground "#b5d18a"))))
 '(font-lock-variable-name-face ((t (:foreground "cornsilk" :inherit bold))))
; '(highlight                    ((t (:foreground "cornsilk" :background "#39312E" :underline t))))
 '(highlight                    ((t (:foreground "cornsilk" :background nil :underline t))))
 '(mode-line                    ((t (:foreground "black" :background "grey75" :inverse-video nil :box nil))))
 '(warning                      ((t (:foreground "darkorange1" :bold nil)))))

(provide-theme 'brown)
