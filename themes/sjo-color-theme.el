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

(defconst +keep-default-faces+
  '(default fixed-pitch variable-pitch bold italic bold-italic))

(defun fix-face-plist (plist)
  (let ((inherits nil)
        (pairs nil))
    (cl-loop for (k v . _) on plist by #'cddr
             do (cl-case k
                  (:bold (when v (push 'bold inherits)))
                  (:weight (when (eq v 'bold) (push 'bold inherits)))
                  (:family (cond ((equal v "courier") (push 'fixed-pitch inherits))
                                 ((equal v "helv") (push 'variable-pitch inherits))))
                  (:inherit (cond ((symbolp v) (push v inherits))
                                  ((listp v) (dolist (face v) (push face inherits)))))
		  ((nil) nil)
                  (otherwise (push (list k v) pairs))))
    (when inherits
      (sort inherits #'string<)
      (delete-consecutive-dups inherits)
      (push (list :inherit inherits) pairs))
    (apply #'nconc (nreverse pairs))))

(defun sjo-face-filter (clause)
  (cl-destructuring-bind (face specs) clause
    (unless (memq face +keep-default-faces+)
      (cl-loop for (display plist) in specs
               collect (list display (fix-face-plist plist)) into new-specs
               finally return (list (canonicalize-face face) new-specs)))))

(defun term-color (face graphic tty)
  `(,face ((((type graphic)) (:background ,graphic :foreground ,graphic))
           (((type tty))     (:background ,tty     :foreground ,tty)))))

(derived-theme-set-faces
 'sjo-color
 'charcoal-black
 :filter #'sjo-face-filter
 ; Style overrides
 '(default ((t (:background "grey7" :foreground "grey75"))))
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
