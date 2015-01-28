(when *is-a-mac*
  ; (setq mac-command-modifier 'none)
  (setq mac-option-modifier 'meta)
  (setq default-input-method "MacOSX")
  ;; Make mouse wheel / trackpad scrolling less jerky
  ;;(setq mouse-wheel-scroll-amount '(0.001))
    (setq mouse-wheel-scroll-amount '(1
                                    ((shift) . 5)
                                    ((control))))
   (dolist (multiple '("" "double-" "triple-"))
    (dolist (direction '("right" "left"))
      (global-set-key (kbd (concat "<" multiple "wheel-" direction ">")) 'ignore)))

  (when *is-cocoa-emacs*
    ;; Woohoo!!
    (global-set-key (kbd "M-`") 'ns-next-frame)
    (global-set-key (kbd "M-h") 'ns-do-hide-emacs)
    (global-set-key (kbd "M-ˍ") 'ns-do-hide-others) ;; what describe-key reports
    (global-set-key (kbd "M-c") 'ns-copy-including-secondary)
    (global-set-key (kbd "M-v") 'ns-paste-secondary)))


(provide 'init-osx-keys)
