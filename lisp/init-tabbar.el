;;; my-tabbar.el ---

;;
;; Author: Hua Liang[Stupid ET] <et@everet.org>
;; Time-stamp: <2014-09-03 13:15:39 Wednesday by Hua Liang>

;; ==================== tabbar ====================
;;tabbar
(require-package 'tabbar)
(require 'tabbar)

(tabbar-mode 1)
(global-set-key (kbd "C-S-<tab>") 'tabbar-backward)
(global-set-key (kbd "C-<tab>") 'tabbar-forward)
(global-set-key (kbd "C-s-<tab>") 'tabbar-backward-group)
(global-set-key (kbd "C-s-S-<tab>") 'tabbar-forward-group)
;;set group strategy
(defun tabbar-buffer-groups ()
  "tabbar group"
  (list
   (cond
    ((memq major-mode '(shell-mode sh-mode))
     "shell"
     )
    ((memq major-mode '(c-mode c++-mode))
     "cc"
     )
    ((memq major-mode '(dired-mode ibuffer-mode))
     "files"
     )
    ((eq major-mode 'python-mode)
     "python"
     )
    ((eq major-mode 'ruby-mode)
     "ruby"
     )
    ((memq major-mode
	   '(php-mode nxml-mode nxhtml-mode))
     "WebDev"
     )
    ((eq major-mode 'emacs-lisp-mode)
     "Emacs-lisp"
     )
    ((memq major-mode
	   '(tex-mode latex-mode text-mode snippet-mode org-mode moinmoin-mode markdown-mode))
     "Text"
     )
    ((string-equal "*" (substring (buffer-name) 0 1))
     "emacs"
     )
    (t
     "other"
     )
    )))
(setq tabbar-buffer-groups-function 'tabbar-buffer-groups)
(setq tabbar-cycling-scope (quote tabs))
(setq tabbar-use-images nil)

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

;; ;;;; 设置tabbar外观
;; ;; 设置默认主题: 字体, 背景和前景颜色，大小
;; (set-face-attribute 'tabbar-default nil
;;                     :family "PragmataPro" ;"Vera Sans YuanTi Mono"
;;                     :background "gray30"
;;                     :foreground "#dcdccc"
;;                     :height 1.0
;;                     )

;; ;; 设置左边按钮外观：外框框边大小和颜色
;; (set-face-attribute 'tabbar-button nil
;;                     :inherit 'tabbar-default
;;                     :box '(:line-width 2 :color "gray30")
;;                     )
;; (set-face-attribute 'tabbar-separator nil
;;                     :inherit 'tabbar-default
;;                     :foreground "blue"
;;                     :background "dark gray"
;;                     :box '(:line-width 2 :color "dark gray" :style 'released-button)
;;                     )
;; ;(setq tabbar-separator-value "§")
;; ;; (setq tabbar-separator (list 0.5))
;; ;; 设置当前tab外观：颜色，字体，外框大小和颜色
;; (set-face-attribute 'tabbar-selected nil
;;                     :inherit 'tabbar-default
;;                     :foreground "orange" ;"DarkGreen"
;;                     :background "dark magenta" ;"LightGoldenrod"
;;                     :box '(:line-width 2
;;                                        :color "DarkGoldenrod"
;;                                        :style 'pressed-button)
;;                     :weight 'bold
;;                     )
;; ;; 设置非当前tab外观：外框大小和颜色
;; (set-face-attribute 'tabbar-unselected nil
;;                     :inherit 'tabbar-default
;;                     :box '(:line-width 2 :color "dark gray" :style 'released-button))

;; ;;cancel grouping
;; (setq tabbar-buffer-groups-function
;;    (lambda (b) (list “All Buffers”)))
;; (setq tabbar-buffer-list-function
;;    (lambda ()
;;        (remove-if
;;          (lambda(buffer)
;;             (find (aref (buffer-name buffer) 0) ” *”))
;;          (buffer-list))))
;;-------------------- tabbar --------------------

(provide 'init-tabbar)


;;; my-tabbar.el ends here
