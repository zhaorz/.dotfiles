;;; mode-line.el
;;;
;;; Richard Zhao
;;;

;;; Code:
(set-face-attribute 'mode-line nil
                    :underline nil
                    :overline nil
                    :background "#eee8d5"
                    )
(set-face-attribute 'mode-line-inactive nil
                    :underline nil
                    :overline nil
                    :background "#f5eeda"
                    )
(set-face-attribute 'mode-line-highlight nil
                    :underline nil
                    :overline nil
                    :background "#93a1a1"
                    :foreground "#eee8d5"
                    )

(defun powerline-custom-theme ()
  "Setup the default mode-line."
  (interactive)
  (setq-default mode-line-format
                '("%e"
                  (:eval
                   (let* ((active (powerline-selected-window-active))
                          (mode-line (if active 'mode-line 'mode-line-inactive))
                          (face1 (if active 'powerline-active1 'powerline-inactive1))
                          (face2 (if active 'powerline-active2 'powerline-inactive2))
                          (separator-left (intern (format "powerline-%s-%s"
                                                          (powerline-current-separator)
                                                          (car powerline-default-separator-dir))))
                          (separator-right (intern (format "powerline-%s-%s"
                                                           (powerline-current-separator)
                                                           (cdr powerline-default-separator-dir))))
                          (lhs (list
                                (if (buffer-modified-p)
                                    (powerline-raw "%*" '(:foreground "#b58900") 'l)
                                  (powerline-raw "%*" nil 'l))
                                (when powerline-display-buffer-size
                                  (powerline-buffer-size nil 'l))
                                (when powerline-display-mule-info
                                  (powerline-raw mode-line-mule-info nil 'l))
                                (powerline-buffer-id nil 'l)
                                (if (file-remote-p default-directory)  ; tramp
                                    (powerline-raw " ♞" '(:foreground "#2aa198") 'l))
                                (if buffer-read-only  ; read only
                                    (powerline-raw " (ro)" '(:foreground "#6c71c4") 'l))
                                (when (and (boundp 'which-func-mode) which-func-mode)
                                  (powerline-raw which-func-format nil 'l))
                                (powerline-raw " ")
                                (funcall separator-left mode-line face1)
                                (when (and (boundp 'erc-track-minor-mode) erc-track-minor-mode)
                                  (powerline-raw erc-modified-channels-object face1 'l))
                                (powerline-major-mode face1 'l)
                                (powerline-process face1)
                                (powerline-minor-modes face1 'l)
                                (powerline-narrow face1 'l)
                                (powerline-raw " " face1)
                                (funcall separator-left face1 face2)
                                (powerline-vc face2 'r)
                                (when (bound-and-true-p nyan-mode)
                                  (powerline-raw (list (nyan-create)) face2 'l))))
                          (rhs (list (powerline-raw global-mode-string face2 'r)
                                     (funcall separator-right face2 face1)
                                     (unless window-system
                                       (powerline-raw (char-to-string #xe0a1) face1 'l))
                                     (powerline-raw "%4l" face1 'l)
                                     (powerline-raw ":" face1 'l)
                                     (powerline-raw "%3c" face1 'r)
                                     (funcall separator-right face1 mode-line)
                                     (powerline-raw evil-mode-line-tag nil 'l)
                                     (powerline-raw "%6p" nil 'r)
                                     (when powerline-display-hud
                                       (powerline-hud face2 face1)))))
                     (concat (powerline-render lhs)
                             (powerline-fill face2 (powerline-width rhs))
                             (powerline-render rhs)))))))

(use-package powerline
  :config
  (powerline-custom-theme)
  (setq powerline-default-separator 'slant))

(provide 'mode-line)
;;; mode-line.el ends here
