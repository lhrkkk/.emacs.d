;;; V.el --- Emacs and vi mode

;; Copyright (C) 2010 ahei

;; Author: ahei <ahei0802@gmail.com>
;; Keywords: emacs vi
;; URL: http://code.google.com/p/dea/source/browse/trunk/my-lisps/V.el
;; Time-stamp: <2012-11-03 04:28:14 Saturday by lhr>

;; This file is  free software; you can redistribute  it and/or modify
;; it under the  terms of the GNU General  Public License as published
;; by  the Free  Software Foundation;  either version  3, or  (at your
;; option) any later version.

;; This file  is distributed in the  hope that it will  be useful, but
;; WITHOUT  ANY  WARRANTY;  without   even  the  implied  warranty  of
;; MERCHANTABILITY or  FITNESS FOR A PARTICULAR PURPOSE.   See the GNU
;; General Public License for more details.

;; You should have  received a copy of the  GNU General Public License
;; along with GNU  Emacs; see the file COPYING.  If  not, write to the
;; Free Software  Foundation, Inc.,  51 Franklin Street,  Fifth Floor,
;; Boston, MA 02110-1301, USA.

;;; Commentary:
;;
;; V-mode make you browse and edit your file quickly.  Use it, you
;; can browse file like vi, but more quickly, and when you browe file,
;; you  can also edit  your file  use Emacs  key bindings.   It's name
;; "V"   is  combine  of   EMACs  and   vI.  Its   screenshots  is
;; http://emacser.com/screenshots/V.png  . This package  is depend
;; on                                                           package
;; http://code.google.com/p/dea/source/browse/trunk/my-lisps/ahei-misc.el
;; and                                                          package
;; http://code.google.com/p/dea/source/browse/trunk/my-lisps/eval-after-load.el
;; . For more details, see article http://emacser.com/V.htm

;;; Installation:
;;
;; Copy V.el to your load-path and add to your .emacs:
;;
;; (require 'V)

;;; History:
;;
;; 2010-04-25
;;      * Add variable V-key-command-alist
;;
;; 2010-3-21
;;      * initial version 1.0.

;;; Code:

(eval-when-compile
  (require 'cl))

(require 'view)
(require 'misc)
(require 'ahei-misc)
(require 'eval-after-load)

(defgroup V nil
  "Minor mode for browse and edit file more quickly."
  :prefix "V-")

;;;###autoload
(defcustom V-mode-line-format (propertize "V" 'face 'V-mode-line-face)
  "Mode line format of function `V-mode'."
  :type 'string
  :group 'V)

(defvar V-mode-map nil  "Keymap for function `V-mode'.")

(defvar V-read-only nil "Readonly before enter in function `V-mode' or not.")
(make-variable-buffer-local 'V-read-only)

(defface V-mode-line-face
  '((((type tty pc)) :bold t :foreground "red" :background "white")
    (t (:background "red" :foreground "white")))
  "Face used highlight `V-mode-line-format'.")

;; must do this
(put 'V-mode-line-format 'risky-local-variable t)

(unless V-mode-map
  (setq V-mode-map (make-sparse-keymap))
  (setq minor-mode-alist
        (append
         `((V-mode " ") (V-mode ,V-mode-line-format))
         (delq (assq 'V-mode minor-mode-alist) minor-mode-alist))))



;;;###autoload
(defun V-add-key-definition (key command &optional condition)
  "Add key definition to `V-key-command-alist'."
  (let* ((cond-commands (nth 1 (assoc key V-key-command-alist)))
         (cond-commands-bak cond-commands))
    (if cond-commands
        (if condition
            (let ((cond-command (assoc condition cond-commands)))
              (if cond-command
                  (unless (eq command (nth 1 cond-command))
                    (setcdr cond-command `(,command)))
                (push `(,condition ,command) (nth 1 (assoc key V-key-command-alist)))))
          (unless (listp (car (last cond-commands)))
            (setq cond-commands (butlast cond-commands)))
          (add-to-list 'cond-commands command t)
          (delq cond-commands-bak V-key-command-alist)
          (add-to-list 'V-key-command-alist `(,key ,cond-commands)))
      (add-to-list 'V-key-command-alist
                   `(,key ,(if condition `((,condition ,command)) `(,command)))))))


;;;###autoload
(defun V-bol-and-quit ()
  "First exit function `V-mode' and then call `back-to-indentation', like I command in vi."
  (interactive)
  (V-mode-off)
  (back-to-indentation))

;;;###autoload
(defun V-eol-and-quit ()
  "First exit function `V-mode' and then call `end-of-line', like A command in vi."
  (interactive)
  (V-mode-off)
  (end-of-line))

;;;###autoload
(defun V-newline-and-quit ()
  "First exit function `V-mode' and then call `newline-and-indent', like o command in vi."
  (interactive)
  (V-mode-off)
  (end-of-line)
  (newline-and-indent))

;;;###autoload
(defun V-roll-down (&optional n)
  "Simulate roll down lines N."
  (interactive "P")
  (if (null n) (setq n 7))
  (next-line n))

;;;###autoload
(defun V-roll-up (&optional n)
  "Simulate roll up lines N."
  (interactive "P")
  (if (null n) (setq n 7))
  (previous-line n))

;; when open exist file automatically enter `V-mode', but if file
;; does not exist, do not enter it.
;;;###autoload
(defun V-exist-file ()
  "Only when variable `buffer-file-name' is exist, enter function `V-mode'."
  (when 1
    (V-mode-on)))


;;;###autoload
(define-minor-mode V-mode
  "Toggle `V-mode'.

  \\{V-mode-map}
Entry to this mode calls the value of `V-mode-hook'
if that value is non-nil.  \\<V-mode-map>"
  :group 'V
  :keymap 'V-mode-map
 )

;;;###autoload
(defun V-mode-on ()
  "Turn on function `V-mode'."
  (interactive)
  (cond ((string-match  "\\.windows" buffer-file-name) nil)
        ((string-match  "\\.revive" buffer-file-name) nil)
    (t (setq buffer-read-only t))
    )
  (V-mode 1))


;;;###autoload
(defun V-mode-off ()
  "Turn off function `V-mode'."
  (interactive)
  (setq buffer-read-only nil)
  (V-mode -1))




;;-----------------全局通用键位设置-------------------

;;b = 标记段落
(define-key V-mode-map  (kbd "b") 'mark-paragraph)
(define-key V-mode-map  (kbd "M-b") 'mark-whole-buffer)
;;, . = 翻页
(define-key V-mode-map  (kbd ",") [prior])
(define-key V-mode-map  (kbd ".") [next])

;;(define-key V-mode-map  (kbd "C-i") [up])
(define-key V-mode-map  "i" [up])
(define-key V-mode-map  (kbd "k") [down])
;;(define-key V-mode-map  (kbd "C-j") [left])
(define-key V-mode-map  "j" [left])
(define-key V-mode-map  (kbd "l") [right])
(define-key V-mode-map  (kbd "M-i") [C-up])
(define-key V-mode-map  (kbd "M-k") [C-down])
(define-key V-mode-map  (kbd "M-j") [C-left])
(define-key V-mode-map  (kbd "M-l") [C-right])
(define-key V-mode-map  (kbd "u") 'sroll-up)
(define-key V-mode-map  (kbd "SPC") 'sroll-down)
(define-key V-mode-map  (kbd "q") 'V-mode-off)


(eal-define-keys-commonly
 V-mode-map
 `(("a"       move-beginning-of-line)
   ("e"       move-end-of-line)
   ("p"       previous-line)
   ("u"       View-scroll-half-page-backward)
   ("S-SPC"   View-scroll-half-page-backward)
   ("SPC"     View-scroll-half-page-forward)
   ("w"       scroll-down)
   ("d"       scroll-up)
   ("<"       beginning-of-buffer)
   (">"       end-of-buffer)
   ("o"       other-window)
   ("1"       delete-other-windows)
   ("2"       split-window-vertically)
   ("3"       split-window-horizontally)
   ("v"       set-mark-command)
   ("B"       eval-buffer)))



(provide 'V)

;;; V.el ends here
