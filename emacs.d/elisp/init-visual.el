;;; init-visual.el
;;;
;;; Richard Zhao
;;;

;;; Code:

(load-theme 'gruvbox t)
(add-to-list 'default-frame-alist
             '(font . "Menlo 12"))
(setq ns-use-srgb-colorspace nil) ; fix weird colors in powerline
(set-face-attribute 'fringe nil
                    :foreground (face-foreground 'default)
                    :background (face-background 'default))

(set-face-foreground 'vertical-border "#555555")

(provide 'visual)
;;; init-visual.el ends here
