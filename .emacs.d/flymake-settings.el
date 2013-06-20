;; Copyright (C) 2010 ahei

;; Author: ahei <ahei0802@gmail.com>
;; URL: http://code.google.com/p/dea/source/browse/trunk/my-lisps/flymake-settings.el
;; Time-stamp: <2011-03-20 17:49:31 Sunday by taoshanwen>

;; This  file is free  software; you  can redistribute  it and/or
;; modify it under the terms of the GNU General Public License as
;; published by  the Free Software Foundation;  either version 3,
;; or (at your option) any later version.

;; This file is  distributed in the hope that  it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR  A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You  should have  received a  copy of  the GNU  General Public
;; License along with  GNU Emacs; see the file  COPYING.  If not,
;; write  to  the Free  Software  Foundation,  Inc., 51  Franklin
;; Street, Fifth Floor, Boston, MA 02110-1301, USA.

(defvar flymake-mode-map (make-sparse-keymap))

(autoload 'flymake-find-file-hook "flymake" "" t)

(add-hook 'find-file-hook 'flymake-find-file-hook)

(defun flymake-settings ()
  "Settings for `flymake'."
  (defvar flymake-makefile-filenames '("Makefile" "makefile" "GNUmakefile") "File names for make.")

  (defun flymake-get-make-gcc-cmdline (source base-dir)
    (let (found)
      (dolist (makefile flymake-makefile-filenames)
        (if (file-readable-p (concat base-dir "/" makefile))
            (setq found t)))
      (if found
          (list "make"
                (list "-s"
                      "-C"
                      base-dir
                      (concat "CHK_SOURCES=" source)
                      "SYNTAX_CHECK_MODE=1"
                      "check-syntax"))
        (let ((gcc-args (list "-o"
                              "/dev/null"
                              ;"-fsyntax-only" ; Doesn’t work correctly with warn_unused_result
                              "-O0"
                              "-S"
                              "-Wall"
                              "-Wextra"
                              "-pedantic"
                              "-x")))
          (if (or (string= (file-name-extension source) "c")
                  (string= (file-name-extension source) "h"))
              (list "gcc" (append gcc-args `("c" ,source "-std=c99")))
            (list "g++" (append gcc-args `("c++" ,source "-std=c++11"))))))))

  (defun flymake-simple-make-gcc-init-impl (create-temp-f use-relative-base-dir use-relative-source build-file-name get-cmdline-f)
    "Create syntax check command line for a directly checked source file.
Use CREATE-TEMP-F for creating temp copy."
    (let* ((args nil)
           (source-file-name buffer-file-name)
           (buildfile-dir (file-name-directory source-file-name)))
      (if buildfile-dir
          (let* ((temp-source-file-name  (flymake-init-create-temp-buffer-copy create-temp-f)))
            (setq args
                  (flymake-get-syntax-check-program-args
                   temp-source-file-name
                   buildfile-dir
                   use-relative-base-dir
                   use-relative-source
                   get-cmdline-f))))
      args))

  (defun flymake-simple-make-gcc-init ()
    (flymake-simple-make-gcc-init-impl 'flymake-create-temp-inplace t t "Makefile" 'flymake-get-make-gcc-cmdline))

  (setq flymake-allowed-file-name-masks
        '(("\\.\\(?:c\\(?:pp\\|xx\\|\\+\\+\\|c\\)?\\|CC\\|hh?\\)\\'" flymake-simple-make-gcc-init)
          ;("\\.xml\\'" flymake-xml-init)
          ;("\\.html?\\'" flymake-xml-init)
          ;("\\.cs\\'" flymake-simple-make-init)
          ;("\\.p[ml]\\'" flymake-perl-init)
          ;("\\.php[345]?\\'" flymake-php-init)
          ;("\\.h\\'" flymake-master-make-header-init flymake-master-cleanup)
          ;("\\.java\\'" flymake-simple-make-java-init flymake-simple-java-cleanup)
          ;("[0-9]+\\.tex\\'" flymake-master-tex-init flymake-master-cleanup)
          ;("\\.tex\\'" flymake-simple-tex-init)
          ;("\\.idl\\'" flymake-simple-make-init)
          ))

  (defun flymake-display-current-warning/error ()
    "Display warning/error under cursor."
    (interactive)
    (let ((ovs (overlays-in (point) (1+ (point)))))
      (dolist (ov ovs)
        (catch 'found
          (when (flymake-overlay-p ov)
            (message (overlay-get ov 'help-echo))
            (throw 'found t))))))

  (defun flymake-goto-next-error-disp ()
    "Go to next error in err ring, and then display warning/error."
    (interactive)
    (flymake-goto-next-error)
    (flymake-display-current-warning/error))

  (defun flymake-goto-prev-error-disp ()
    "Go to previous error in err ring, and then display warning/error."
    (interactive)
    (flymake-goto-prev-error)
    (flymake-display-current-warning/error))

  (defun flymake-settings-4-emaci ()
    "`flymake' settings for `emaci'."
    (emaci-add-key-definition
     "z" 'flymake-display-current-warning/error
     '(memq major-mode dev-modes)))

  (eval-after-load "emaci"
    `(flymake-settings-4-emaci))

;; Fix warning matching for newer versions of GCC
(defvar flymake-warning-regexp "\\(^\\|[0-9]+: \\)[wW]arning"
  "Regexp against which compiler output is checked to differentiate between warnings and errors")

(defun flymake-parse-line (line)
  "Parse LINE to see if it is an error or warning.
Return its components if so, nil otherwise."
  (let ((raw-file-name nil)
	(line-no 0)
	(err-type "e")
	(err-text nil)
	(patterns flymake-err-line-patterns)
	(matched nil))
    (while (and patterns (not matched))
      (when (string-match (car (car patterns)) line)
	(let* ((file-idx (nth 1 (car patterns)))
	       (line-idx (nth 2 (car patterns))))

	  (setq raw-file-name (if file-idx (match-string file-idx line) nil))
	  (setq line-no       (if line-idx (string-to-number (match-string line-idx line)) 0))
	  (setq err-text      (if (> (length (car patterns)) 4)
				  (match-string (nth 4 (car patterns)) line)
				(flymake-patch-err-text (substring line (match-end 0)))))
	  (or err-text (setq err-text "<no error text>"))
	  (if (and err-text (string-match flymake-warning-regexp err-text))
	      (setq err-type "w")
	    )
	  (flymake-log 3 "parse line: file-idx=%s line-idx=%s file=%s line=%s text=%s" file-idx line-idx
		       raw-file-name line-no err-text)
	  (setq matched t)))
      (setq patterns (cdr patterns)))
    (if matched
	(flymake-ler-make-ler raw-file-name line-no err-type err-text)
      ()))))

(eval-after-load "flymake"
  `(flymake-settings))

(loop for (keybind function) in
      `((,(kbd "C-c n")        flymake-goto-next-error-disp)
        (,(kbd "C-c p")        flymake-goto-prev-error-disp)
        (,(kbd "C-c RET")      flymake-display-current-warning/error)
        (,(kbd "<C-return>")   flymake-display-err-menu-for-current-line)) do
        (define-key flymake-mode-map
          keybind function))

(provide 'flymake-settings)
