;;; hyper-greek.el --- insert Greek characters using the Hyper key

(require 'load-utility)

(define-minor-mode hyper-greek-mode
  "Minor mode for typing Greek characters with the Hyper key"
  t
  t
  (let ((keymap (make-sparse-keymap))
        (keys '(("H-a" . ?α) ("H-A" . ?Α)
                ("H-b" . ?β) ("H-B" . ?Β)
                ("H-g" . ?γ) ("H-G" . ?Γ)
                ("H-d" . ?δ) ("H-D" . ?Δ)
                ("H-e" . ?ε) ("H-E" . ?Ε)
                ("H-z" . ?ζ) ("H-Z" . ?Ζ)
                ("H-h" . ?η) ("H-H" . ?Η)
                ("H-þ" . ?θ) ("H-Þ" . ?Θ)
                ("H-i" . ?ι) ("H-I" . ?Ι)
                ("H-k" . ?κ) ("H-K" . ?Κ)
                ("H-l" . ?λ) ("H-L" . ?Λ)
                ("H-m" . ?μ) ("H-M" . ?Μ)
                ("H-n" . ?ν) ("H-N" . ?Ν)
                ("H-x" . ?ξ) ("H-X" . ?Ξ)
                ("H-o" . ?ο) ("H-O" . ?Ο)
                ("H-p" . ?π) ("H-P" . ?Π)
                ("H-r" . ?ρ) ("H-R" . ?Ρ)
                ("H-s" . ?σ) ("H-S" . ?Σ)
                ("H-ß" . ?ς)
                ("H-t" . ?τ) ("H-T" . ?Τ)
                ("H-u" . ?υ) ("H-U" . ?Υ)
                ("H-f" . ?φ) ("H-F" . ?Φ)
                ("H-q" . ?χ) ("H-Q" . ?Χ)
                ("H-c" . ?ψ) ("H-C" . ?Ψ)
                ("H-w" . ?ω) ("H-W" . ?Ω))))
    (mapc (λ (binding)
            (define-key keymap
              (read-kbd-macro (car binding))
              (make-insert-command (cdr binding))))
          keys)
    keymap)
  :global t)

(provide 'hyper-greek)
