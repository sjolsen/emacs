;;; Customize display settings

;; Enriched text
(add-hook 'enriched-mode-hook #'variable-pitch-mode)

;; Color theme
(require 'color-theme)
(setq color-theme-is-global t)
(color-theme-initialize)
(color-theme-charcoal-black)

;; Graphical-only settings
(defun do-graphics-settings (&optional frame)
  (interactive)
  (if (null frame)
      (setq frame (selected-frame)))
  (if (null (window-system frame))
      (progn
        (xterm-mouse-mode))

    (progn
      ;; Window size
      (set-frame-size frame 120 50)

      ;; Make emacs semitransparent
      (set-frame-parameter frame 'alpha '(95 95))

      ;; Disable the toolbar
      (tool-bar-mode 0)

      ;; Powerline settings
      (load-file "~/.emacs.d/powerline.el")
      (set-face-attribute 'mode-line nil
                          :background "sky blue")
      (set-face-attribute 'mode-line-inactive nil
                          :background "dark gray"
                          :foreground "black")

      ;; Enable X clipboard support
      (setq x-select-enable-clipboard t))))

(do-graphics-settings)
(add-hook 'server-visit-hook 'do-graphics-settings)

;; Frame creation settings
(defadvice make-frame-command (after frame-customization activate)
  (do-graphics-settings ad-return-value))
(defadvice server-create-window-system-frame (after server-frame-customization activate)
  (do-graphics-settings ad-return-value)
  (ensure-ansi-term))
(defadvice server-create-tty-frame (after server-tty-frame-customization activate)
  (ensure-ansi-term))

;; Enable UTF-8 encoding
(set-language-environment "UTF-8")
(setenv "LC_LOCALE" "en_US.UTF-8")
(setenv "LC_CTYPE" "en_US.UTF-8")
(setq slime-net-coding-system 'utf-8-unix)

;; Truncate long lines
(setq truncate-partial-width-windows t)
(setq truncate-lines t)

;; Display column number
(column-number-mode)

;; Window movement
(global-set-key [C-M-left] 'windmove-left)
(global-set-key [C-M-right] 'windmove-right)
(global-set-key [C-M-up] 'windmove-up)
(global-set-key [C-M-down] 'windmove-down)

;; kmic default font
(when (string= system-name "kmic.cs.txstate.edu")
  (face-spec-set 'default '((t (:inherit nil :stipple nil :background "Grey15" :foreground "Grey" :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 108 :width normal :foundry "xos4" :family "terminus"))))
  (face-spec-set 'menu '((t (:background "grey" :foreground "black"))))
  (face-spec-set 'header-line '((t (:foreground "grey90" :box nil)))))
