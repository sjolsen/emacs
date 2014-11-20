(deftheme elpa-settings
  "Settings for Emacs' package manager")

(require 'package)
(package-initialize)

(setq package-archives '(("gnu"       . "http://elpa.gnu.org/packages/")
                         ("marmalade" . "http://marmalade-repo.org/packages/")
                         ("melpa"     . "http://melpa.milkbox.net/packages/")))

(defvar *elpa-packages*
  '(auctex
    auto-complete
    dash
    epl
    git-commit-mode
    git-rebase-mode
    magit
    pkg-info))

(defun archive-contents-file (archive-name)
  (concat package-user-dir
          "/archives"
          "/" archive-name
          "/archive-contents"))

(defun ensure-package-archives ()
  (unless (loop for (archive . address) in package-archives
                always (file-exists-p (archive-contents-file archive)))
    (package-refresh-contents)))

;; (ensure-package-archives)
;; (mapc (λ (package)
;;         (unless (package-installed-p package)
;;           (package-install package)))
;;       *elpa-packages*)



(custom-theme-set-variables
 'elpa-settings
 '(package-enable-at-startup nil))

(provide-theme 'elpa-settings)
