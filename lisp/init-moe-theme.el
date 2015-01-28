(require-package 'moe-theme)

(require 'moe-theme)

;;(setq moe-theme-resize-markdown-title '(2.0 1.7 1.5 1.3 1.0 1.0))
(setq moe-theme-resize-org-title '(2.2 1.8 1.6 1.4 1.2 1.0 1.0 1.0 1.0))
(setq moe-theme-resize-rst-title '(2.0 1.7 1.5 1.3 1.1 1.0))

;;  (require 'moe-theme-switcher)
;;  (setq moe-theme-highlight-buffer-id 1)
(setq moe-light-pure-white-background-in-terminal t)
(setq moe-theme-mode-line-color 'purple)
(moe-light)
(powerline-moe-theme)
;(load-theme 'moe-light t)

;; (let ((class '((class color) (min-colors 89)))
;;       ;; Palette colors.
;;       (yellow-1 "#fce94f") (yellow-2 "#ffd700") (yellow-3 "#c4a000") (yellow-4 "#875f00")
;;       (orange-1 "#ffaf5f") (orange-2 "#ff8700") (orange-3 "#ff5d17") (orange-4 "#d75f00")
;;       (magenta-1 "#ff7bbb") (magenta-2 "#ff4ea3") (magenta-3 "#ff1f8b")
;;       (green-1 "#afff00") (green-2 "#a1db00") (green-3 "#00af00") (green-4 "#008700") (green-5 "#005f00")
;;       (blue-1 "#5fafd7") (blue-2 "#1f5bff") (blue-3 "#005f87") (blue-4 "#005faf") (blue-5 "#0000af")
;;       (cyan-1 "#87ffff") (cyan-2 "#5fd7af") (cyan-3 "#00d7af") (cyan-4 "#00ac8a") (cyan-5 "#5faf87") (cyan-6 "#005f5f") (cyan-7 "#005f87") (cyan-8 "#00af87")
;;       (purple-1 "#d18aff") (purple-2 "#9a08ff") (purple-3 "#6c0099") (purple-4 "#6c0099")
;;       (red-1 "#ef2929")  (red-2 "#cc0000")  (red-3 "#a40000")
;;       (white-1 "#eeeeee") (white-2 "#dadada") (white-3 "#c6c6c6") (white-4 "#b2b2b2") (black-1 "#9e9e9e")
;;       (black-2 "#8a8a8a") (black-3 "#767676") (black-4 "#626262") (black-5 "#5f5f5f") (black-6 "#3a3a3a")
;;       (LIGHT_BG "#fdfde7") (white-0 "#ffffff")
;;       (green-02 "#5fd700") (green-01 "#d7ff00") (green-0 "#d7ff5f") (green-00 "#d7ff87")
;;       (blue-01 "#c3c9f8") (blue-0 "#afd7ff") (blue-00 "#d7d7ff") (blue-000 "#d4e5ff")
;;       (yellow-0 "#ffff87") (yellow-00 "#ffffaf") (yellow-2-5 "#ffba27")
;;       (purple-0 "#af87ff") (purple-00 "#e6a8df")
;;       (red-0 "#ff4b4b") (red-00 "#ffafaf") (red-000 "#ffd5e5")
;;       (magenta-0 "#ffafd7") (magenta-00 "#ffd7ff")
;;       (orange-0 "#ffaf87") (orange-00 "#ffd787") (orange-000 "#ffd7af")
;;       (linum-dark "#87875f") (linum-light "#d7d7af")
;;       )


;;   (custom-theme-set-faces
;;    'moe-light
;;    ;; Ensure sufficient contrast on low-color terminals.
;;    `(default ((((class color) (min-colors 4096))
;;                (:foreground ,black-5 :background ,LIGHT_BG))
;;               (((class color) (min-colors 256))
;;                (:foreground ,black-5 :background ,LIGHT_BG))
;;               (,class
;;                (:foreground ,black-5 :background ,LIGHT_BG))))
;;    `(org-block ((,class (:foreground ,blue-3 :background ,blue-00))))
;;    `(org-block-background ((,class (:background ,white-1))))
;;    `(org-block-begin-line ((,class (:foreground ,blue-3 :background ,blue-0))))
;;    `(org-block-end-line ((,class (:foreground ,white-2 :background ,white-1))))
;;    ))

(provide 'init-moe-theme)
