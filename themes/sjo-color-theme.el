(deftheme sjo-color
  "Customizations on top of charcoal-black.")

(require 'derived-theme)

(defun canonical-face-name (face)
  (string-remove-suffix "-face" (downcase (symbol-name face))))

(defconst +canonical-faces+
  (let ((table (make-hash-table :test 'equal)))
    (dolist (face (face-list))
      (puthash (canonical-face-name face) face table))
    table))

(defun canonicalize-face (face)
  (gethash (canonical-face-name face) +canonical-faces+ face))

(defun plist-delete (plist key)
  (cl-loop for (k v . _) on plist by #'cddr
           unless (equal k key) nconcing (list k v)))

(defun sjo-face-filter (clause)
  (cl-destructuring-bind (face specs) clause
    (cl-loop for (display plist) in specs
             collect (list display (plist-delete plist :family)) into new-specs
             finally return (list (canonicalize-face face) new-specs))))

(derived-theme-set-faces
 'sjo-color
 'charcoal-black
 :filter #'sjo-face-filter
 ; Basic font rendering
 '(default ((t (:family "Liberation Mono" :background "grey7" :foreground "grey75"))))
 '(fixed-pitch ((t (:family "Liberation Mono"))))
 '(variable-pitch ((t (:family "Deja Vu Serif"))))
 '(italic ((t (:italic t))))
 '(bold-italic ((t (:inherit (bold italic)))))
 ; Basic element styling
 '(fringe ((t (:background "Grey10"))))
 '(mode-line ((t (:background "grey75" :foreground "black" :inverse-video nil :box nil))))
 ; Not styled by charcoal-black
 '(org-verbatim ((t (:inherit shadow :foreground "dark orange"))))
 '(shadow ((t (:foreground "dim grey"))))
 '(term-color-black ((((type x)) (:background "Grey15" :foreground "Grey15")) (((type tty)) (:background "black" :foreground "black"))))
 '(term-color-blue ((((type x)) (:background "#438CCA" :foreground "#438CCA")) (((type tty)) (:background "blue" :foreground "blue"))))
 '(term-color-cyan ((((type x)) (:background "#00FFFF" :foreground "#00FFFF")) (((type tty)) (:background "cyan" :foreground "cyan"))))
 '(term-color-green ((((type x)) (:background "#3BB878" :foreground "#3BB878")) (((type tty)) (:background "green" :foreground "green"))))
 '(term-color-magenta ((((type x)) (:background "#F06EA9" :foreground "#F06EA9")) (((type tty)) (:background "magenta" :foreground "magenta"))))
 '(term-color-red ((((type x)) (:background "#F7977A" :foreground "#F7977A")) (((type tty)) (:background "red" :foreground "red"))))
 '(term-color-white ((((type x)) (:background "Grey" :foreground "Grey")) (((type tty)) (:background "white" :foreground "white"))))
 '(term-color-yellow ((((type x)) (:background "#FFF79A" :foreground "#FFF79A")) (((type tty)) (:background "yellow" :foreground "yellow")))))

(derived-theme-set-variables
 'sjo-color
 'charcoal-black)

(provide-theme 'sjo-color)
