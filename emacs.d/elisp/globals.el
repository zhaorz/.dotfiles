;;; globals.el
;;;
;;; Richard Zhao
;;;

;;; Code:

;; General
(setq inhibit-startup-message t)
(setq ring-bell-function 'ignore)
(setq-default indent-tabs-mode nil) ; never use tabs
(setq-default tab-width 4)
(setq show-paren-delay 0)
(show-paren-mode 1)
(fset 'yes-or-no-p 'y-or-n-p)
(setq help-window-select t)
(setq backup-directory-alist `((".*" . "~/.emacs.d/tmp"))
      auto-save-file-name-transforms `((".*" , "~/.emacs.d/tmp" t)))

;; Keymaps
(define-key global-map (kbd "s-{") 'previous-buffer)
(define-key global-map (kbd "s-}") 'next-buffer)

;; Hooks
(add-hook 'prog-mode-hook 'turn-on-auto-fill)
(add-hook 'before-save-hook 'delete-trailing-whitespace)
(add-hook 'org-mode-hook
          (lambda()
            (auto-fill-mode t)))

(provide 'globals)
;;; globals.el ends here
