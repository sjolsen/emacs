(deftheme dired-settings
  "Settings for Dired")

(require 'dired-x)
(add-hook 'dired-mode-hook #'dired-omit-mode)

(define-keys dired-mode
  ("M-p" . #'dired-prev-marked-file)
  ("M-o" . #'dired-omit-mode)
  ("M-n" . #'dired-next-marked-file))

(defvar *dired-no-omit-extensions* '(".bin"))
(defvar *completion-no-ignored-extensions* '(".bin" ".git/"))



(custom-theme-set-variables
 'dired-settings
 '(completion-ignored-extensions (remove-all *completion-no-ignored-extensions*
                                             (custom-standard-value 'completion-ignored-extensions)))
 '(dired-omit-extensions (remove-all *dired-no-omit-extensions*
                                     (custom-standard-value 'dired-omit-extensions)))
 '(dired-omit-files "^\\.[^.]+\\|.+~"))

(provide-theme 'dired-settings)
