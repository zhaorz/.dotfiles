;;; visual.el
;;;
;;; Richard Zhao
;;;

;;; Code:

(load-theme 'solarized-light t)
(add-to-list 'default-frame-alist
             '(font . "Source Code Pro 11"))
(setq ns-use-srgb-colorspace nil) ; fix weird colors in powerline

(provide 'visual)
;;; visual.el ends here
