;; -*- Emacs-Lisp -*-

;; Time-stamp: <2011-11-15 18:04:47 Tuesday by lhr>


(if window-system
    (progn
      (defun my-fullscreen ()       ;全屏
    (interactive)
    (x-send-client-message
     nil 0 nil "_NET_WM_STATE" 32
     '(2 "_NET_WM_STATE_FULLSCREEN" 0))
    )
      (defun my-maximized () ;该函数用于最大化,状态值为1说明最大化后不会被还原
    (interactive) ;因为这里有两次最大化 (分别是水平和垂直)
    (x-send-client-message
     nil 0 nil "_NET_WM_STATE" 32
     '(1 "_NET_WM_STATE_MAXIMIZED_HORZ" 0))
    (interactive)
    (x-send-client-message
     nil 0 nil "_NET_WM_STATE" 32
     '(1 "_NET_WM_STATE_MAXIMIZED_VERT" 0)))
      (global-set-key [f11] 'my-fullscreen)
      (my-maximized)))



(provide 'maxframe-simple)
