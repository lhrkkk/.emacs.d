(require-package 'workgroups2)
(require 'workgroups2)

(setq wg-use-default-session-file nil)
;(workgroups-mode 1) ; put this one at the bottom of .emacs
;; by default, the sessions are saved in "~/.emacs_workgroups"
(autoload 'wg-create-workgroup "workgroups2" nil t)
(autoload 'wg-kill-workgroup "workgroups2" nil t)
(autoload 'wg-find-session-file "workgroups2" nil t)
(autoload 'wg-read-workgroup-name "workgroups2" nil t)
(autoload 'wg-switch-to-workgroup "workgroups2" nil t)
(autoload 'wg-switch-to-workgroup-at-index "workgroups2" nil t)
(autoload 'wg-save-session "workgroups2" nil t)
(autoload 'wg-switch-to-buffer "workgroups2" nil t)
(autoload 'wg-switch-to-workgroup-left "workgroups2" nil t)
(autoload 'wg-switch-to-workgroup-right "workgroups2" nil t)
(autoload 'wg-undo-wconfig-change "workgroups2" nil t)
(autoload 'wg-redo-wconfig-change "workgroups2" nil t)
(autoload 'wg-save-wconfig "workgroups2" nil t)




(setq wg-emacs-exit-save-behavior           'save)      ; Options: 'save 'ask nil
(setq wg-workgroups-mode-exit-save-behavior 'save)      ; Options: 'save 'ask nil

;; Mode Line changes
;; Display workgroups in Mode Line?
(setq wg-mode-line-display-on t)          ; Default: (not (featurep 'powerline))
(setq wg-flag-modified t)                 ; Display modified flags as well
(setq wg-mode-line-decor-left-brace "["
      wg-mode-line-decor-right-brace "]"  ; how to surround it
      wg-mode-line-decor-divider ":")
(provide 'init-workgroups2)
