;;; hscroll.el --- Bindings for horizontal scrolling

;; Copyright (C) 2013 Stuart Olsen

;; This program is free software: you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <http://www.gnu.org/licenses/>.

;; Hscroll

(defun current-line-length () (interactive)
  (save-excursion (move-end-of-line nil) (current-column)))

(defmacro defmouse-scroll-function (name do-scroll)
  `(defun ,name (event distance)
     (let* ((mouse-position (mouse-position))
            (scroll-window
             (condition-case nil
                 (window-at (cadr mouse-position) (cddr mouse-position)
                            (car mouse-position))
               (error nil)))
            (old-window (selected-window)))
       (select-window scroll-window)
       (,do-scroll distance)
       (select-window old-window))))

(defmouse-scroll-function mouse-scroll-left scroll-left)
(defmouse-scroll-function mouse-scroll-right scroll-right)

(defadvice mouse-scroll-left (around mouse-scroll-left-margin-check activate)
  (let* ((advance (min (ad-get-arg 1)
                       (- (current-line-length) (current-column))))
         (virtual-column (- (current-column) (window-hscroll))))
    (forward-char (max (1+ (- hscroll-margin (- virtual-column advance)))
                       0))
    (ad-set-arg 1 advance)
    ad-do-it))

(defadvice mouse-scroll-right (around mouse-scroll-right-margin-check activate)
  (let* ((advance (min (ad-get-arg 1)
                       (window-hscroll)))
         (virtual-column (- (current-column) (window-hscroll)))
         (edge-distance (- (window-width) virtual-column)))
    (backward-char (max (1+ (- hscroll-margin (- edge-distance advance)))
                        0))
    (ad-set-arg 1 advance)
    ad-do-it))

(provide 'hscroll)
