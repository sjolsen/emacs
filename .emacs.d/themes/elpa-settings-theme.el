(deftheme elpa-settings
  "Settings for Emacs' package manager")

(custom-theme-set-variables
 'elpa-settings
;'(package-enable-at-startup nil)
 '(package-archives (quote (("gnu"       . "http://elpa.gnu.org/packages/")
                            ("marmalade" . "http://marmalade-repo.org/packages/")
                            ("melpa"     . "http://melpa.milkbox.net/packages/")))))

(provide-theme 'elpa-settings)
