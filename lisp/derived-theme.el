(defun derived-theme-get (theme type)
  "Collect the faces or variables associated with a theme definition."
  (load-theme theme :no-enable t)
  (cl-loop for (this-type name _ value) in (get theme 'theme-settings)
           when (eq this-type type)
           collect (list name value)))

(defun derived-theme-set-faces (theme supertheme &rest args)
  "Like `custom-theme-set-faces', but apply the faces from the specified
supertheme first."
  (let* ((orig-args (derived-theme-get supertheme 'theme-face))
         (new-args (cl-concatenate 'list args orig-args)))
    (apply #'custom-theme-set-faces theme new-args)))

(defun derived-theme-set-variables (theme supertheme &rest args)
  "Like `custom-theme-set-variables', but apply the variables from the specified
supertheme first."
  (let* ((orig-args (derived-theme-get supertheme 'theme-value))
         (new-args (cl-concatenate 'list args orig-args)))
    (apply #'custom-theme-set-variables theme new-args)))

(defun merge-face-specs (specs)
  "Merge face spec alists as defined by `defface'."
  (let ((display-plists (make-hash-table :test 'equal)))
    (dolist (spec specs)
      (cl-loop for (display atts) in spec
               do (push atts (gethash display display-plists))))
    (cl-loop for display being the hash-keys of display-plists
             using (hash-values rev-plists)
             ; Use the last plist
             collect (list display (car rev-plists)))))

(defun merge-theme-settings (theme)
  "Retrieve and merge `theme-settings' entries for `theme'."
  (let ((settings (make-hash-table :test 'equal)))
    (cl-loop for (type name theme-name spec) in (get theme 'theme-settings)
             for key = (list type name theme-name)
             do (push spec (gethash key settings)))
    (cl-loop for key being the hash-keys of settings
             using (hash-values rev-specs)
             for specs = (reverse rev-specs)
             collect (cons key (merge-face-specs specs)))))

(defun format-derived-theme (theme supertheme faces values)
  "Pretty-print the `derived-theme-set-faces' and `derived-theme-set-variables'
clauses computed by `compute-derived-theme'."
  (cl-labels ((format-clause (command rows)
                (cl-loop for row in (cl-list* theme supertheme rows)
                         concat (format "\n '%S" row) into rows-text
                         finally return (format "(%s%s)" command rows-text))))
    (let ((clauses (list (format-clause 'derived-theme-set-faces faces)
                         (format-clause 'derived-theme-set-variables values))))
      (mapconcat #'identity clauses "\n\n"))))

(defun compute-derived-theme (theme supertheme)
  "Given an existing `theme' and `supertheme', provide an alternate definition
of `theme' that applies only necessary changes on top of `supertheme'."
  (load-theme theme :no-enable t)
  (load-theme supertheme :no-enable t)
  (cl-labels ((massage (setting)
                (cl-destructuring-bind ((type name _) . value)
                    setting
                  `((,type . ,name) . ,value)))
              (get-theme-settings (theme)
                (mapcar #'massage (merge-theme-settings theme))))
    (let* ((a-props     (get-theme-settings theme))
           (b-props     (get-theme-settings supertheme))
           (keys        (cl-union (mapcar #'car a-props) (mapcar #'car b-props)))
           (unique-keys (cl-sort (delete-dups keys) #'string-lessp
                                 :key (lambda (k) (format "%s" k)))))
      (cl-loop for key in unique-keys
               for (type . name) = key
               for a-val = (cdr (assoc key a-props))
               for b-val = (cdr (assoc key b-props))
               for row = (list name a-val)
               unless (equal a-val b-val)
                 when (eq type 'theme-value) collect row into values end
                 and when (eq type 'theme-face) collect row into faces end
               finally return (format-derived-theme theme supertheme faces values)))))

(provide 'derived-theme)
