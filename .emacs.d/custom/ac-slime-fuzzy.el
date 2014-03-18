;;; ac-slime-fuzzy.el --- Fuzzy auto-completion for SLIME
;;; -*- lexical-binding: t -*-

;; Author: Stuart Olsen <stuart@sj-olsen.com>
;; Created: 2014-03-04
;; Keywords: abbrev convenience lisp

;; This file is not part of GNU Emacs.

;;; Commentary:

;; Provides an auto-complete source for the SLIME REPL, using fuzzy
;; completions. Adapted largely from Steve Purcell's `ac-slime'
;; (https://github.com/purcell/ac-slime).

;;; Code:


;;; Package definitions:

(eval-when-compile (require 'cl))
(require 'slime-fuzzy)
(require 'auto-complete)
(provide 'ac-slime-fuzzy)

(defgroup ac-slime-fuzzy nil
  "Fuzzy auto-completion source for SLIME"
  :prefix "ac-slime-fuzzy:"
  :group 'auto-complete)

(defcustom ac-slime-fuzzy:*completion-limit* 50
  "The maximum number of completion candidates to process when auto-completing."
  :tag "Completion Limit"
  :type '(integer :validate ac-slime-fuzzy::custom-validate-positive-integer)
  :group 'ac-slime-fuzzy)

(defcustom ac-slime-fuzzy:*propertizers* (list #'ac-slime-fuzzy::propertize-score
                                               #'ac-slime-fuzzy::propertize-flags)
  "Propertization functions to apply to each completion candidate.

Each function should take a partially propertized string and completion as
defined by `swank:fuzzy-completions' and should return a further propertized
string."
  :tag "Propertizers"
  :type '(list function)
  :group 'ac-slime-fuzzy)



(defun ac-slime-fuzzy::custom-validate-positive-integer (widget)
  (let ((value (widget-value widget)))
    (unless (and (typep value 'integer)
                 (> value 0))
      (widget-put widget :error "Expected a positive integer"))))


;;; Auto-complete definitions:

(defvar ac-slime-fuzzy:*ac-source*
  `((available  . ,#'ac-slime-fuzzy:available)
    (candidates . ,#'ac-slime-fuzzy:candidates)
    (document   . ,#'ac-slime-fuzzy:document)
    (limit      . ,#'ac-slime-fuzzy:*completion-limit*)
    (prefix     . ,#'ac-slime-fuzzy:prefix)))

(defun ac-slime-fuzzy:available ()
  "Report whether we're available for auto-completion"
  (slime-connected-p))

(defun ac-slime-fuzzy:candidates (&optional prefix)
  "Get a list of completions for the prefix at point"
  (let ((prefix (or prefix ac-prefix))
        (slime-fuzzy-completion-limit ac-slime-fuzzy:*completion-limit*))
    (mapcar #'ac-slime-fuzzy::prepare-candidate
            (ac-slime-fuzzy::get-raw-candidates prefix))))

(defun ac-slime-fuzzy:document (symbol)
  "Get the documentation for `symbol'"
  (slime-eval `(swank:documentation-symbol ,(substring-no-properties symbol))))

(defun ac-slime-fuzzy:prefix ()
  "Find a start point for a completion prefix"
  (slime-symbol-start-pos))



(defun ac-slime-fuzzy::get-raw-candidates (prefix)
  "Returns a list of fuzzy completions, each of which has the format described
by `swank:fuzzy-completions'."
  ;; `slime-fuzzy-completions' returns two values; we want the first.
  (first (slime-fuzzy-completions (substring-no-properties prefix))))

(defun ac-slime-fuzzy::prepare-candidate (candidate)
  "Apply our propertization functions to the candidate"
  (loop for propertizer in ac-slime-fuzzy:*propertizers*
        for string = (funcall propertizer (first candidate) candidate)
        then (funcall propertizer string candidate)
        finally (return string)))

(defun ac-slime-fuzzy::propertize-score (prop-string candidate)
  "Add the fuzzy completion score to the candidate"
  (propertize prop-string 'summary (second candidate)))

(defun ac-slime-fuzzy::propertize-flags (prop-string candidate)
  "Add the fuzzy completion score to the candidate"
  (propertize prop-string 'symbol (fourth candidate)))

;;; ac-slime-fuzzy.el ends here
