(deftheme clojure
  "Settings for Clojure")

(define-keys clojure-mode
  ("<return>" . #'newline-and-indent)
  ("RET"      . #'newline-and-indent))

(provide-theme 'clojure)
