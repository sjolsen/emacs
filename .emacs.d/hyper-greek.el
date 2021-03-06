(defmacro define-insert-key-for-map (map-name key-str char)
  `(define-key ,map-name (read-kbd-macro ,key-str) (lambda (&optional ARG) (interactive) (insert-char ,char (or ARG 1)))))

(define-minor-mode hyper-greek-mode
  "Minor mode for typing Greek characters with the Hyper key"
  t
  t
  (let ((keymap (make-sparse-keymap)))
    (define-insert-key-for-map keymap "H-a" ?α)
    (define-insert-key-for-map keymap "H-b" ?β)
    (define-insert-key-for-map keymap "H-g" ?γ)
    (define-insert-key-for-map keymap "H-d" ?δ)
    (define-insert-key-for-map keymap "H-e" ?ε)
    (define-insert-key-for-map keymap "H-z" ?ζ)
    (define-insert-key-for-map keymap "H-h" ?η)
    (define-insert-key-for-map keymap "H-þ" ?θ)
    (define-insert-key-for-map keymap "H-i" ?ι)
    (define-insert-key-for-map keymap "H-k" ?κ)
    (define-insert-key-for-map keymap "H-l" ?λ)
    (define-insert-key-for-map keymap "H-m" ?μ)
    (define-insert-key-for-map keymap "H-n" ?ν)
    (define-insert-key-for-map keymap "H-x" ?ξ)
    (define-insert-key-for-map keymap "H-o" ?ο)
    (define-insert-key-for-map keymap "H-p" ?π)
    (define-insert-key-for-map keymap "H-r" ?ρ)
    (define-insert-key-for-map keymap "H-s" ?σ)
    (define-insert-key-for-map keymap "H-ß" ?ς)
    (define-insert-key-for-map keymap "H-t" ?τ)
    (define-insert-key-for-map keymap "H-u" ?υ)
    (define-insert-key-for-map keymap "H-f" ?φ)
    (define-insert-key-for-map keymap "H-q" ?χ)
    (define-insert-key-for-map keymap "H-c" ?ψ)
    (define-insert-key-for-map keymap "H-w" ?ω)

    (define-insert-key-for-map keymap "H-A" ?Α)
    (define-insert-key-for-map keymap "H-B" ?Β)
    (define-insert-key-for-map keymap "H-G" ?Γ)
    (define-insert-key-for-map keymap "H-D" ?Δ)
    (define-insert-key-for-map keymap "H-E" ?Ε)
    (define-insert-key-for-map keymap "H-Z" ?Ζ)
    (define-insert-key-for-map keymap "H-H" ?Η)
    (define-insert-key-for-map keymap "H-Þ" ?Θ)
    (define-insert-key-for-map keymap "H-I" ?Ι)
    (define-insert-key-for-map keymap "H-K" ?Κ)
    (define-insert-key-for-map keymap "H-L" ?Λ)
    (define-insert-key-for-map keymap "H-M" ?Μ)
    (define-insert-key-for-map keymap "H-N" ?Ν)
    (define-insert-key-for-map keymap "H-X" ?Ξ)
    (define-insert-key-for-map keymap "H-O" ?Ο)
    (define-insert-key-for-map keymap "H-P" ?Π)
    (define-insert-key-for-map keymap "H-R" ?Ρ)
    (define-insert-key-for-map keymap "H-S" ?Σ)
    (define-insert-key-for-map keymap "H-T" ?Τ)
    (define-insert-key-for-map keymap "H-U" ?Υ)
    (define-insert-key-for-map keymap "H-F" ?Φ)
    (define-insert-key-for-map keymap "H-Q" ?Χ)
    (define-insert-key-for-map keymap "H-C" ?Ψ)
    (define-insert-key-for-map keymap "H-W" ?Ω)

    keymap)
  :global t)
