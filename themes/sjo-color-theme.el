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

(defun term-color (face graphic tty)
  `(,face ((((type graphic)) (:background ,graphic :foreground ,graphic))
           (((type tty))     (:background ,tty     :foreground ,tty)))))

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
 (term-color 'ansi-color-black   "grey7"   "black")
 (term-color 'ansi-color-blue    "#438CCA" "blue")
 (term-color 'ansi-color-cyan    "#00FFFF" "cyan")
 (term-color 'ansi-color-green   "#3BB878" "green")
 (term-color 'ansi-color-magenta "#F06EA9" "magenta")
 (term-color 'ansi-color-red     "#F7977A" "red")
 (term-color 'ansi-color-white   "white"   "white")
 (term-color 'ansi-color-yellow  "#FFF79A" "yellow"))

(derived-theme-set-variables
 'sjo-color
 'charcoal-black)

(provide-theme 'sjo-color)
