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



(autoload 'flymake-find-file-hook "flymake" "" t)
(add-hook 'find-file-hook 'flymake-find-file-hook)

(defun parent-directory (directory)
  (unless (string= "/" directory)
    (file-name-directory (directory-file-name directory))))

(defvar flymake-makefile-filenames '("Makefile" "makefile" "GNUmakefile") "File names for make.")

(defun syntax-checkable-p (makefile)
  (zerop (call-process "make" nil nil nil "-s" "-n" "check-syntax" "-f" makefile)))

;; Search recursively upward for a makefile
(defun find-makefile (base-dir)
  (if base-dir
      (let ((found-makefile nil))
        (dolist (makefile flymake-makefile-filenames)
          (let ((makefile-fullname (concat base-dir "/" makefile)))
            (if (and (file-readable-p makefile-fullname)
                     (syntax-checkable-p makefile-fullname))
                (setq found-makefile makefile-fullname))))
        (or found-makefile
            (find-makefile (parent-directory base-dir))))))



(defvar flymake-default-makefile "~/emacs/.emacs.d/flymake-default-makefile")
(defvar flymake-default-temp-dir temporary-file-directory)

(defvar default-c-compiler
  (if (executable-find "clang")
      "clang"
    "cc"))

(defvar default-c++-compiler
  (cond
   ((executable-find "clang++")
    "clang++")
   ((executable-find "g++-4.8")
    "g++-4.8")
   (t
    "c++")))

(defvar default-c++11-flag
  (cond
   ((or (executable-find "clang++")
        (executable-find "g++-4.8"))
    "-std=c++11")
   (t
    "-std=c++0x")))


(defun flymake-create-temp-in-temp-dir (file-name prefix)
  (unless (stringp file-name)
    (error "Invalid file-name"))
  (or prefix
      (setq prefix "flymake"))
  (let* ((ext (file-name-extension file-name))
	 (temp-name (file-truename
		     (concat flymake-default-temp-dir "/"
                             (file-name-sans-extension file-name)
			     "_" prefix
			     (and ext (concat "." ext))))))
    (flymake-log 3 "create-temp-in-temp-dir: file=%s temp=%s" file-name temp-name)
    temp-name))

(defun flymake-settings ()
  "Settings for `flymake'."

  (defun flymake-get-make-cc-cmdline (program-name
                                      program-specifier
                                      flags
                                      flags-specifier
                                      source base-dir)
    "Computes the command to be used to perform the syntax check. PROGRAM_NAME
specifies the program to be used (e.g., \"gcc\"). PROGRAM-SPECIFIER is the name
the makefile uses to perform the syntax check (e.g., \"CC\"). FLAGS-SPECIFIER is
the variable the makefile uses to pass arguments to the program (such as
\"CFLAGS\"), SOURCE is the source file to be parsed, and BASE-DIR is the
directory in which the original file resides."
    (let ((makefile (find-makefile base-dir)))
      (unless makefile
        (setq makefile (expand-file-name flymake-default-makefile)))
      (list "make"
            (list "-s"
                  "-C" base-dir
                  "-f" makefile
                  (concat "CHK_SOURCES=" source)
                  (concat program-specifier "=" program-name)
                  (concat flags-specifier "=-I " base-dir " " flags)
                  "check-syntax"))))

  (defun flymake-simple-make-cc-init-impl (create-temp-f use-relative-base-dir use-relative-source build-file-name get-cmdline-f)
    "Create syntax check command line for a directly checked source file.
Use CREATE-TEMP-F for creating temp copy."
    (let* ((args nil)
           (source-file-name buffer-file-name)
           (buildfile-dir (file-name-directory source-file-name)))
      (if buildfile-dir
          (let* ((temp-source-file-name (flymake-init-create-temp-buffer-copy create-temp-f)))
            (setq args
                  (flymake-get-syntax-check-program-args
                   temp-source-file-name
                   buildfile-dir
                   use-relative-base-dir
                   use-relative-source
                   get-cmdline-f))))
      args))

  (defun flymake-make-c-cmdline (source base-dir)
    (flymake-get-make-cc-cmdline default-c-compiler "CC" "-std=c99" "CFLAGS" source base-dir))
  (defun flymake-make-c++-cmdline (source base-dir)
    (flymake-get-make-cc-cmdline default-c++-compiler "CXX" default-c++11-flag "CXXFLAGS" source base-dir))
  (defun flymake-make-cuda-cmdline (source base-dir)
    (flymake-get-make-cc-cmdline "nvcc" "NVCXX" "" "NVCXXFLAGS" source base-dir))
  (defun flymake-make-mic-cmdline (source base-dir)
    (flymake-get-make-cc-cmdline "icpc" "MICXX" "-std=c++11" "MICXXFLAGS" source base-dir))

  (defun flymake-simple-make-c-init ()
    (flymake-simple-make-cc-init-impl 'flymake-create-temp-in-temp-dir t t "Makefile" 'flymake-make-c-cmdline))
  (defun flymake-simple-make-c++-init ()
    (flymake-simple-make-cc-init-impl 'flymake-create-temp-in-temp-dir t t "Makefile" 'flymake-make-c++-cmdline))
  (defun flymake-simple-make-cuda-init ()
    (flymake-simple-make-cc-init-impl 'flymake-create-temp-in-temp-dir t t "Makefile" 'flymake-make-cuda-cmdline))
  (defun flymake-simple-make-mic-init ()
    (flymake-simple-make-cc-init-impl 'flymake-create-temp-in-temp-dir t t "Makefile" 'flymake-make-mic-cmdline))

  (setq flymake-allowed-file-name-masks
        '(("\\.[ch]\\'" flymake-simple-make-c-init)
          ("\\.\\(cc\\|hh\\)\\'" flymake-simple-make-c++-init)
          ("\\.cu\\(hh\\)?\\'" flymake-simple-make-cuda-init)
          ("\\.mic[ch]\\'" flymake-simple-make-mic-init)
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

(defvar flymake-mode-map (make-sparse-keymap))
(loop for (keybind function) in
      `((,(kbd "C-c n")        flymake-goto-next-error-disp)
        (,(kbd "C-c p")        flymake-goto-prev-error-disp)
        (,(kbd "C-c RET")      flymake-display-current-warning/error)
        (,(kbd "<C-return>")   flymake-display-err-menu-for-current-line)
        (,(kbd "<f5>")         flymake-start-syntax-check)) do
        (define-key flymake-mode-map
          keybind function))

(provide 'flymake-settings)
