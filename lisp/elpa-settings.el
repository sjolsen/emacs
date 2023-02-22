(require 'package)
(package-initialize)

(setq package-archives '(("gnu"   . "http://elpa.gnu.org/packages/")
                         ("melpa" . "http://melpa.org/packages/")))

(defvar *elpa-packages*
  '(auctex
    auto-complete
    color-theme-modern
    magit
    multiple-cursors
    page-break-lines
    slime
    smart-tabs-mode
    undo-tree))

(defun uninstalled-elpa-packages ()
  (cl-remove-if #'package-installed-p *elpa-packages*))

(defun install-elpa-packages ()
  (let ((packages (uninstalled-elpa-packages)))
    (when (not (null packages))
      (let ((prompt (format "The following packages are not installed: %s. Install them?"
                            packages)))
        (when (y-or-n-p prompt)
          (package-refresh-contents)
          (mapc #'package-install packages))))))

(provide 'elpa-settings)
