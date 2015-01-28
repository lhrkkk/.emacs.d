;;; elscreen-settings.el ---

;; Copyright (C) 2011 Free Software Foundation, Inc.
;;
;; Author: luhaorui <luhaorui@gmail.com>
;; Maintainer: luhaorui <luhaorui@gmail.com>
;; Created: 15 Nov 2011
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
;;   (require 'elscreen-settings)

;;; Code:

;; (eval-when-compile
;;   (require 'cl))
(require-package 'elscreen)
(require 'elscreen)
(elscreen-start)

(require-package 'elscreen-persist )
(require 'elscreen-persist )
(elscreen-persist-mode 1)

(require-package 'evil-tabs )
(require 'evil-tabs )
(global-evil-tabs-mode t)


;; (require-package 'frame-restore )
;; (require 'frame-restore )
;; (frame-restore-mode)
;; (desktop-save-mode)

;; (defun elscreen-frame-title-update ()
;;    (when (elscreen-screen-modified-p 'elscreen-frame-title-update)
;;      (let* ((screen-list (sort (elscreen-get-screen-list) '<))
;;        (screen-to-name-alist (elscreen-get-screen-to-name-alist))
;;        (title (mapconcat
;;            (lambda (screen)
;;              (format "%d%s %s"
;;                  screen (elscreen-status-label screen)
;;                  (get-alist screen screen-to-name-alist)))
;;            screen-list " ")))
;;        (if (fboundp 'set-frame-name)
;;       (set-frame-name title)
;;     (setq frame-title-format title)))))

;;  (eval-after-load "elscreen"
;;    '(add-hook 'elscreen-screen-update-hook 'elscreen-frame-title-update))
;; (load "elscreen" "ElScreen" t)
;; (require 'elscreen-dired)
;; ;;(require 'elscreen-server)
;; (require 'elscreen-speedbar)
;; (require 'elscreen-color-theme)
;; (require 'elscreen-gf)


;; (setq   elscreen-tab-display-kill-screen 'left)
;; (setq   elscreen-display-tab nil)

;; (define-key elscreen-map [?\H-j] 'elscreen-previous)
;; (define-key elscreen-map "j"    'elscreen-previous)
;; (define-key elscreen-map "\C-l" 'elscreen-next)
;; (define-key elscreen-map "l"    'elscreen-next)
;; (define-key elscreen-map "\C-z" 'elscreen-toggle)
;; (define-key elscreen-map "z"    'elscreen-toggle)
;; (define-key elscreen-map "\C-b"    'elscreen-find-and-goto-by-buffer)
;; (define-key elscreen-map "\C-a" 'elscreen-display-screen-name-list)
;; (define-key elscreen-map "a"    'elscreen-display-screen-name-list)

;; (global-set-key  [?\C-9] 'elscreen-previous)
;; (global-set-key  [?\C-0]   'elscreen-next)
;; (global-set-key  [?\C-8]   'elscreen-kill)


(provide 'init-elscreen)
;;; elscreen-settings.el ends here
