(deftheme dired-settings
  "Settings for Dired")

(require 'dired-x)
(add-hook 'dired-mode-hook #'dired-omit-mode)

(define-keys dired-mode
  ("M-p" . #'dired-prev-marked-file)
  ("M-n" . #'dired-next-marked-file))



(custom-theme-set-variables
 'dired-settings
 '(dired-omit-files "^\\.[^.]+\\|.+~"))

(provide-theme 'dired-settings)
