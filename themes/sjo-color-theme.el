(deftheme sjo-color
  "Created 2014-02-11.")

(require 'derived-theme)

(derived-theme-set-faces
 'sjo-color
 'charcoal-black
 ; Replace non-italicized color-coded italics
 '(bold-italic ((t (:inherit (bold italic)))))
 '(italic ((t (:italic t))))
 ; Darker background
 '(default ((t (:background "grey7" :foreground "grey"))))
 '(fringe ((t (:background "Grey10"))))
 ; Replace Helvetica with Deja Vu Serif
 '(info-menu-header ((t (:inherit (variable-pitch bold)))))
 '(info-title-1 ((t (:inherit info-title-2 :height 1.728))))
 '(info-title-2 ((t (:inherit info-title-3 :height 1.44))))
 '(info-title-3 ((t (:inherit info-title-4 :height 1.2))))
 '(info-title-4 ((t (:inherit (variable-pitch bold)))))
 '(variable-pitch ((t (:family "Deja Vu Serif"))))
 ; Misspelled in charcoal-black
 '(lazy-highlight ((t (:background "paleturquoise4"))))
 '(show-paren-match ((t (:background "light slate blue" :foreground "white"))))
 '(show-paren-mismatch ((t (:background "red" :foreground "white"))))
 '(widget-button ((t (:bold t :weight bold))))
 '(widget-button-pressed ((t (:foreground "red"))))
 '(widget-documentation ((t (:foreground "light blue"))))
 '(widget-field ((t (:background "RoyalBlue4" :foreground "wheat"))))
 '(widget-inactive ((t (:foreground "dim gray"))))
 '(widget-single-line-field ((t (:background "slate blue" :foreground "wheat"))))
 ; Remove raised border
 '(mode-line ((t (:background "grey75" :foreground "black" :inverse-video nil :box nil))))
 ; Not styled by charcoal-black
 '(org-verbatim ((t (:inherit shadow :foreground "dark orange"))))
 '(shadow ((t (:foreground "dim grey"))))
 '(term-color-black ((((type x)) (:background "Grey15" :foreground "Grey15")) (((type tty)) (:background "black" :foreground "black"))))
 '(term-color-blue ((((type x)) (:background "#438CCA" :foreground "#438CCA")) (((type tty)) (:background "blue" :foreground "blue"))))
 '(term-color-cyan ((((type x)) (:background "#00FFFF" :foreground "#00FFFF")) (((type tty)) (:background "cyan" :foreground "cyan"))))
 '(term-color-green ((((type x)) (:background "#3BB878" :foreground "#3BB878")) (((type tty)) (:background "green" :foreground "green"))))
 '(term-color-magenta ((((type x)) (:background "#F06EA9" :foreground "#F06EA9")) (((type tty)) (:background "magenta" :foreground "magenta"))))
 '(term-color-red ((((type x)) (:background "#F7977A" :foreground "#F7977A")) (((type tty)) (:background "red" :foreground "red"))))
 '(term-color-white ((((type x)) (:background "Grey" :foreground "Grey")) (((type tty)) (:background "white" :foreground "white"))))
 '(term-color-yellow ((((type x)) (:background "#FFF79A" :foreground "#FFF79A")) (((type tty)) (:background "yellow" :foreground "yellow")))))

(derived-theme-set-variables
 'sjo-color
 'charcoal-black)

(provide-theme 'sjo-color)
