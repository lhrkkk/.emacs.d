
(require-package 'leuven-theme)
(require 'leuven-theme)

(load-theme 'leuven t)
(setq org-fontify-whole-heading-line t)
(set-face-attribute 'org-level-1 nil :height 90) ; 9 pt font

(provide 'init-leuven-theme)