;;; emacs-buffer.el --- Emacs and vi mode

;; Copyright (C) 2010 ahei

;; Author: ahei <ahei0802@gmail.com>
;; Keywords: emacs vi
;; URL: http://code.google.com/p/dea/source/browse/trunk/my-lisps/emacs-buffer.el
;; Time-stamp: <2011-11-23 20:11:35 Wednesday by lhr>

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
;; emacs-buffer-mode make you browse and edit your file quickly.  Use it, you
;; can browse file like vi, but more quickly, and when you browe file,
;; you  can also edit  your file  use Emacs  key bindings.   It's name
;; "emacs-buffer"   is  combine  of   EMACs  and   vI.  Its   screenshots  is
;; http://emacser.com/screenshots/emacs-buffer.png  . This package  is depend
;; on                                                           package
;; http://code.google.com/p/dea/source/browse/trunk/my-lisps/ahei-misc.el
;; and                                                          package
;; http://code.google.com/p/dea/source/browse/trunk/my-lisps/eval-after-load.el
;; . For more details, see article http://emacser.com/emacs-buffer.htm

;;; Installation:
;;
;; Copy emacs-buffer.el to your load-path and add to your .emacs:
;;
;; (require 'emacs-buffer)

;;; History:
;;
;; 2010-04-25
;;      * Add variable emacs-buffer-key-command-alist
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
(require 'V)
(defgroup emacs-buffer nil
  "Minor mode for browse and edit file more quickly."
  :prefix "emacs-buffer-")



;; ;;;###autoload
;; (defcustom emacs-buffer-key-command-alist
;;   `(("n" (((edebug-active) edebug-next-mode)
;;           ((eq major-mode 'gud-mode) gud-next)
;;           next-line))
;;     ("g" (((edebug-active) edebug-go-mode)
;;           beginning-of-buffer))
;;     ("b" (((edebug-active) edebug-set-breakpoint)
;;           backward-word))
;;     ("q" (((edebug-active) top-level)
;;           emacs-buffer-mode-off)))
;;   "This variable is a list, its element is a list whose first
;; element is a key, and second element is a list which consist by
;; many pairs whose first element is a condition, and second element is
;; a command."
;;   :type 'list
;;   :group 'emacs-buffer)


;; ;;;###autoload
;; (defcustom emacs-buffer-mode-line-format (propertize "Emacs-Buffer" 'face 'emacs-buffer-mode-line-face)
;;   "Mode line format of function `emacs-buffer-mode'."
;;   :type 'string
;;   :group 'emacs-buffer)


;; (defface emacs-buffer-mode-line-face
;;  '((((type tty pc)) :bold t :foreground "red" :background "white")
;;    (t (:background "red" :foreground "white")))
;;   "Face used highlight `emacs-buffer-mode-line-format'.")

;; ;; must do this
;; (put 'emacs-buffer-mode-line-format 'risky-local-variable t)

;; (unless emacs-buffer-mode-map
;;   (setq emacs-buffer-mode-map (make-sparse-keymap))
;;   (setq minor-mode-alist
;;         (append
;;          `((emacs-buffer-mode " ") (emacs-buffer-mode ,emacs-buffer-mode-line-format))
;;          (delq (assq 'emacs-buffer-mode minor-mode-alist) minor-mode-alist))))


(defvar emacs-buffer-mode-map (make-sparse-keymap)  "Keymap for function `emacs-buffer-mode'.")

;;;###autoload
(defun emacs-buffer-add-key-definition (key command &optional condition)
  "Add key definition to `emacs-buffer-key-command-alist'."
  (let* ((cond-commands (nth 1 (assoc key emacs-buffer-key-command-alist)))
         (cond-commands-bak cond-commands))
    (if cond-commands
        (if condition
            (let ((cond-command (assoc condition cond-commands)))
              (if cond-command
                  (unless (eq command (nth 1 cond-command))
                    (setcdr cond-command `(,command)))
                (push `(,condition ,command) (nth 1 (assoc key emacs-buffer-key-command-alist)))))
          (unless (listp (car (last cond-commands)))
            (setq cond-commands (butlast cond-commands)))
          (add-to-list 'cond-commands command t)
          (delq cond-commands-bak emacs-buffer-key-command-alist)
          (add-to-list 'emacs-buffer-key-command-alist `(,key ,cond-commands)))
      (add-to-list 'emacs-buffer-key-command-alist
                   `(,key ,(if condition `((,condition ,command)) `(,command)))))))


;;;###autoload
(defun emacs-buffer-bol-and-quit ()
  "First exit function `emacs-buffer-mode' and then call `back-to-indentation', like I command in vi."
  (interactive)
  (emacs-buffer-mode-off)
  (back-to-indentation))

;;;###autoload
(defun emacs-buffer-eol-and-quit ()
  "First exit function `emacs-buffer-mode' and then call `end-of-line', like A command in vi."
  (interactive)
  (emacs-buffer-mode-off)
  (end-of-line))

;;;###autoload
(defun emacs-buffer-newline-and-quit ()
  "First exit function `emacs-buffer-mode' and then call `newline-and-indent', like o command in vi."
  (interactive)
  (emacs-buffer-mode-off)
  (end-of-line)
  (newline-and-indent))

;;;###autoload
(defun emacs-buffer-roll-down (&optional n)
  "Simulate roll down lines N."
  (interactive "P")
  (if (null n) (setq n 7))
  (next-line n))

;;;###autoload
(defun emacs-buffer-roll-up (&optional n)
  "Simulate roll up lines N."
  (interactive "P")
  (if (null n) (setq n 7))
  (previous-line n))

(add-hook 'after-change-major-mode-hook 'emacs-buffer-mode-on)



;;;###autoload
(define-minor-mode emacs-buffer-mode
  "Toggle `emacs-buffer-mode'.

  \\{emacs-buffer-mode-map}
Entry to this mode calls the value of `emacs-buffer-mode-hook'
if that value is non-nil.  \\<emacs-buffer-mode-map>"
  :group 'emacs-buffer
  :keymap 'emacs-buffer-mode-map
 )

;;;###autoload
(defun emacs-buffer-mode-on ()
  "Turn on function `emacs-buffer-mode'."
  (interactive)
  (when buffer-file-name
  (when (file-exists-p (buffer-file-name))
      (V-mode-on)
    ))
;;  (V-mode-on)
  (emacs-buffer-mode 1)
  )

;;;###autoload
(defun emacs-buffer-mode-off ()
  "Turn off function `emacs-buffer-mode'."
  (interactive)
  (emacs-buffer-mode -1))




;;-----------------全局通用键位设置-------------------

;;b = 标记段落
(define-key emacs-buffer-mode-map  (kbd "C-b") 'mark-paragraph)
(define-key emacs-buffer-mode-map  (kbd "M-b") 'mark-whole-buffer)
;;, . = 翻页
(define-key emacs-buffer-mode-map  (kbd "M-,") [prior])
(define-key emacs-buffer-mode-map  (kbd "M-.") [next])


;; 翻译C-i和C-j Translate the problematic keys to the function key Hyper:
(keyboard-translate ?\C-i ?\H-i)
(keyboard-translate ?\C-j ?\H-j)
;(keyboard-translate ?\C-m ?\H-m)
;(keyboard-translate ?\C-d ?\H-d)
;; Rebind then accordantly:
;(define-key emacs-buffer-mode-map  [?\H-m] 'set-mark-command)
;;i k j l = 上下左右

;;(define-key emacs-buffer-mode-map  (kbd "C-i") [up])
(define-key emacs-buffer-mode-map  [?\H-i] [up])
(define-key emacs-buffer-mode-map  (kbd "C-k") [down])
;;(define-key emacs-buffer-mode-map  (kbd "C-j") [left])
(define-key emacs-buffer-mode-map  [?\H-j] [left])
(define-key emacs-buffer-mode-map  (kbd "C-l") [right])
(define-key emacs-buffer-mode-map  (kbd "M-i") [C-up])
(define-key emacs-buffer-mode-map  (kbd "M-k") [C-down])
(define-key emacs-buffer-mode-map  (kbd "M-j") [C-left])
(define-key emacs-buffer-mode-map  (kbd "M-l") [C-right])

;;p = delete 删除 向后删单词
;;n = kill-line 删除行
;; (define-key emacs-buffer-mode-map  (kbd "C-p") "\C-d")
(define-key emacs-buffer-mode-map  (kbd "C-p") [delete])
;;(define-key emacs-buffer-mode-map  (kbd "M-p") 'kill-word)
(define-key emacs-buffer-mode-map  (kbd "M-p") "\M-d")
(define-key emacs-buffer-mode-map  (kbd "C-M-p") 'my-kill-word)
(define-key emacs-buffer-mode-map  (kbd "C-n") 'kill-line)
(define-key emacs-buffer-mode-map  (kbd "M-n") 'kill-whole-line)

;;h = backspace 退格键 向前删单词
(define-key emacs-buffer-mode-map  (kbd "M-h") 'backward-kill-word)
;;C-TAB = indent
(define-key emacs-buffer-mode-map  [C-tab] 'indent-for-tab-command)



;;window控制键位
(defun display-buffer-name ()
(interactive)
(message (buffer-file-name (current-buffer))))

(defun back-window ()
  (interactive)
  (other-window -1))
;;9,0 = tabbar 和 window 的切换
;;(define-key emacs-buffer-mode-map  (kbd "C-M-9")'tabbar-backward-group)
;;(define-key emacs-buffer-mode-map  (kbd "C-M-0") 'tabbar-forward-group)
;;(define-key emacs-buffer-mode-map  (kbd "C-9") 'tabbar-backward)
;;(define-key emacs-buffer-mode-map  (kbd "C-0") 'tabbar-forward)
(define-key emacs-buffer-mode-map  (kbd "M-9") 'back-window)
(define-key emacs-buffer-mode-map  (kbd "M-0") 'other-window)

;; ;;tabbar废弃,使用elscreen
;; (define-key emacs-buffer-mode-map  (kbd "C-9") 'elscreen-previous)
;; (define-key emacs-buffer-mode-map  (kbd "C-0") 'elscreen-next)
;; (define-key emacs-buffer-mode-map  (kbd "C-8") 'elscreen-kill)

;; (define-key emacs-buffer-mode-map  (kbd "C-M-9")'tabbar-backward-group)



;;8 = 关闭buffer 或者 window
(define-key emacs-buffer-mode-map  (kbd "M-8") 'delete-window)
(define-key emacs-buffer-mode-map  (kbd "C-M-8") 'kill-buffer-and-window)

;;1,2,3控制窗口分割
(define-key emacs-buffer-mode-map  (kbd "M-1") 'delete-other-windows)
(define-key emacs-buffer-mode-map  (kbd "M-2") 'split-window-vertically)
(define-key emacs-buffer-mode-map  (kbd "M-3") 'split-window-horizontally)
;;(define-key emacs-buffer-mode-map  [(meta backspace)] 'delete-window)
(define-key emacs-buffer-mode-map  (kbd "M-5") 'display-buffer-name)

;;jump 到文件
(define-key emacs-buffer-mode-map  (kbd "C-x f") 'find-file-at-point)
;;重载buffer
(define-key emacs-buffer-mode-map  (kbd "C-x c") 'revert-buffer)




;;调整line or region 的上下位置
(define-key emacs-buffer-mode-map  [s-up] (quote move-region-up))
(define-key emacs-buffer-mode-map  [s-down] (quote move-region-down))
;;旋转window
(define-key emacs-buffer-mode-map  "\M-7" 'circle-windows)
(define-key emacs-buffer-mode-map  "\M-s" 'V-mode-on)
(define-key emacs-buffer-mode-map  "\M-S" 'V-mode-off)



(apply-define-key
 global-map
 `(("M-s" V-mode-on)
   ("M-S" V-mode-off)))


(provide 'emacs-buffer)

;;; emacs-buffer.el ends here
