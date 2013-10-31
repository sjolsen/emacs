(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ac-clang-flags (quote ("-std=c++11")))
 '(ac-delay 0.5)
 '(column-number-mode t)
 '(custom-file "~/.emacs.d/custom-settings.el")
 '(fci-rule-character-color nil)
 '(fci-rule-color "dim gray")
 '(flymake-fringe-indicator-position nil)
 '(flymake-gui-warnings-enabled nil)
 '(font-use-system-font t)
 '(global-page-break-lines-mode t)
 '(global-semantic-idle-scheduler-mode nil)
 '(global-semanticdb-minor-mode nil)
 '(inhibit-startup-screen t)
 '(mouse-wheel-scroll-amount (quote (1 ((control)))))
 '(page-break-lines-char 45)
 '(page-break-lines-modes (quote (emacs-lisp-mode lisp-mode scheme-mode compilation-mode outline-mode help-mode c-mode c++-mode text-mode)))
 '(semantic-mode t)
 '(semantic-stickyfunc-indent-string "")
 '(send-mail-function (quote smtpmail-send-it))
 '(show-paren-mode t)
 '(smtpmail-smtp-server "echo.nixihost.com")
 '(smtpmail-smtp-service 465)
 '(smtpmail-smtp-user "stuart@sj-olsen.com")
 '(smtpmail-stream-type (quote ssl))
 '(term-scroll-snap-to-bottom nil)
 '(tool-bar-mode nil)
 '(tramp-default-host "localhost")
 '(tramp-default-proxies-alist (quote (("kmic.*" "\\`root\\'" "/ssh:stuart@%h:") ("\\`dakara" "\\`root\\'" "/ssh:sjo@%h:"))))
 '(truncate-lines t)
 '(user-mail-address "stuart@sj-olsen.com")
 '(warning-suppress-types (quote ((undo discard-info)))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(flymake-errline ((((type x)) (:underline "red2")) (((type tty)) (:background "red"))))
 '(flymake-warnline ((((type x)) (:underline "medium blue")) (((type tty)) (:background "blue"))))
 '(term-color-black ((((type x)) (:background "Grey15" :foreground "Grey15")) (((type tty)) (:background "black" :foreground "black"))))
 '(term-color-blue ((((type x)) (:background "#438CCA" :foreground "#438CCA")) (((type tty)) (:background "blue" :foreground "blue"))))
 '(term-color-cyan ((((type x)) (:background "#00FFFF" :foreground "#00FFFF")) (((type tty)) (:background "cyan" :foreground "cyan"))))
 '(term-color-green ((((type x)) (:background "#3BB878" :foreground "#3BB878")) (((type tty)) (:background "green" :foreground "green"))))
 '(term-color-magenta ((((type x)) (:background "#F06EA9" :foreground "#F06EA9")) (((type tty)) (:background "magenta" :foreground "magenta"))))
 '(term-color-red ((((type x)) (:background "#F7977A" :foreground "#F7977A")) (((type tty)) (:background "red" :foreground "red"))))
 '(term-color-white ((((type x)) (:background "Grey" :foreground "Grey")) (((type tty)) (:background "white" :foreground "white"))))
 '(term-color-yellow ((((type x)) (:background "#FFF79A" :foreground "#FFF79A")) (((type tty)) (:background "yellow" :foreground "yellow"))))
 '(variable-pitch ((t (:family "Droid Serif")))))
(put 'upcase-region 'disabled nil)
(put 'downcase-region 'disabled nil)