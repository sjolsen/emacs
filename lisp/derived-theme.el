(defun derived-theme-get (theme type)
  "Collect the faces or variables associated with a theme definition."
  (load-theme theme :no-enable t)
  (loop for (this-type name _ value) in (get theme 'theme-settings)
        when (eq this-type type)
        collect (list name value)))

(defun derived-theme-get-face-table (theme)
  "Create a hash table for the specified theme's faces."
  (loop with result = (make-hash-table :test 'equal)
        for (name value) in (derived-theme-get theme 'theme-face)
        do (puthash name value result)
        finally return result))

(defun derived-theme-set-faces (theme supertheme &rest args)
  "Like `custom-theme-set-faces', but apply the faces from the specified
supertheme first."
  (let* ((orig-args (derived-theme-get supertheme 'theme-face))
         (new-args (concatenate 'list args orig-args)))
    (apply #'custom-theme-set-faces theme new-args)))

(defun derived-theme-set-variables (theme supertheme &rest args)
  "Like `custom-theme-set-variables', but apply the variables from the specified
supertheme first."
  (let* ((orig-args (derived-theme-get supertheme 'theme-value))
         (new-args (concatenate 'list args orig-args)))
    (apply #'custom-theme-set-variables theme new-args)))

(defun format-derived-theme (theme supertheme faces values)
  "Pretty-print the `derived-theme-set-faces' and `derived-theme-set-variables'
clauses computed by `compute-derived-theme'."
  (cl-labels ((format-clause (command rows)
                (loop for row in (list* theme supertheme rows)
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
                (cl-destructuring-bind (type name _ value)
                    setting
                  `((,type . ,name) . ,value)))
              (get-theme-settings (theme)
                (mapcar #'massage (get theme 'theme-settings))))
    (let* ((a-props     (get-theme-settings theme))
           (b-props     (get-theme-settings supertheme))
           (keys        (cl-union (mapcar #'car a-props) (mapcar #'car b-props)))
           (unique-keys (cl-sort (delete-dups keys) #'string-lessp
                                 :key (lambda (k) (format "%s" k)))))
      (loop for key in unique-keys
            for (type . name) = key
            for a-val = (cdr (assoc key a-props))
            for b-val = (cdr (assoc key b-props))
            for row = (list name a-val)
            unless (equal a-val b-val)
              when (eq type 'theme-value) collect row into values end
              and when (eq type 'theme-face) collect row into faces end
            finally return (format-derived-theme theme supertheme faces values)))))

(provide 'derived-theme)
