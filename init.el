(require 'cl)

;; Allow loading this Emacs configuration without modifying the user's primary
;; configuration. Can be loaded either with "emacs -q -l /path/to/init.el" or by
;; pointing ~/.emacs at init.el.
(setq user-init-file (file-truename (or load-file-name (buffer-file-name))))
(setq user-emacs-directory (file-name-directory user-init-file))
;; Several custom variables reference user-emacs-directory before we get a
;; chance to override it. Fix them up.
(mapatoms (lambda (var)
	    (when (boundp var)
	      (let ((old-val (eval var)))
		(when (and (stringp old-val)
			   (cl-search "/.emacs.d/" old-val))
		  (let ((new-val (custom-reevaluate-setting var)))
		    (message "Reevaluated %s from %S to %S"
			     var old-val new-val)))))))

(message "Loaded Emacs configuration from %s" user-init-file)
