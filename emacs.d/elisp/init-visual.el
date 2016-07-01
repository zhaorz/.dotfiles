;;; visual.el
;;;
;;; Richard Zhao
;;;

;;; Code:

(load-theme 'solarized-light t)
(add-to-list 'default-frame-alist
             '(font . "Menlo 12"))
(setq ns-use-srgb-colorspace nil) ; fix weird colors in powerline

(provide 'visual)
;;; visual.el ends here
