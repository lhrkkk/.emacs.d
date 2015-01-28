;;; tabbar-settings.el ---

;; Copyright (C) 2011 Free Software Foundation, Inc.
;;
;; Author: ahei <ahei0802@gmail.com>
;; Maintainer: ahei <ahei0802@gmail.com>
;; Created: 10 Aug 2011
;; Version: 0.01
;; Keywords

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation; either version 2, or (at your option)
;; any later version.
;;
;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.
;;
;; You should have received a copy of the GNU General Public License
;; along with this program; if not, write to the Free Software
;; Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.

;;; Commentary:

;;

;; Put this file into your load-path and the following into your ~/.emacs:
;;   (require 'tabbar-settings)

;;; Code:

(eval-when-compile
  (require 'cl))





;;-----------tabbar-mode----------------

(require 'tabbar)
(tabbar-mode t)

;;tabbar按键绑定
;; (global-set-key (kbd "s-j") 'tabbar-backward)
;; (global-set-key (kbd "s-l") 'tabbar-forward)
;; (global-set-key (kbd "s-i") 'tabbar-backward-group)
;; (global-set-key (kbd "s-k") 'tabbar-forward-group)
;; 组内循环滚动tab
(setq tabbar-cycling-scope (quote tabs))
;; 外观设置
;; tab内凹表明选定
(custom-set-faces
'(tabbar-default-face
((t (:inherit variable-pitch
:background "gray90"
:foreground "gray60"
:height 0.8))))
'(tabbar-selected-face
((t (:inherit tabbar-default-face
:foreground "darkred"
:box (:line-width 2 :color "white" :style pressed-button)))))
'(tabbar-unselected-face
((t (:inherit tabbar-default-face
:foreground "black"
:box (:line-width 2 :color "white" :style released-button))))))
;(require 'cl)

(defun tabbar-buffer-groups (buffer)
   "Return the list of group names BUFFER belongs to.
 Return only one group for each buffer."
   (with-current-buffer (get-buffer buffer)
     (cond
      ((string-equal "*" (substring (buffer-name) 0 1))
       '("Emacs Buffer"))
      ((eq major-mode 'dired-mode)
       '("Dired"))
      (t
       '("User Buffer"))
      )))






(provide 'tabbar-settings)
;;; tabbar-settings.el ends here
