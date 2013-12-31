(deftheme basic-desktop
  "Basic settings for desktop use of Emacs")

(add-user-subdir-to-load-path "external/")
(require 'page-break-lines)

(custom-theme-set-variables
 'basic-desktop
 '(page-break-lines-char 45)
 '(global-page-break-lines-mode t)
 '(default-frame-alist (quote ((width . 120)
                               (height . 50)
                               (alpha 95 95))))
 '(inhibit-startup-screen t)
 '(truncate-lines t)
 '(current-language-environment "UTF-8")
 '(tool-bar-mode nil))

(provide-theme 'basic-desktop)
