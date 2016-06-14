;;; custom-diminish.el
;;;
;;; Richard Zhao
;;;

;;; Code:

(eval-after-load 'auto-fill-mode
  '(diminish 'auto-fill-function))

(diminish 'undo-tree-mode)

(eval-after-load 'auto-revert-mode
  '(diminish 'auto-revert-mode))

(add-hook 'emacs-lisp-mode-hook
          (lambda()
            (setq mode-name "λ")))

(add-hook 'term-mode-hook
          (lambda()
            (setq mode-name "τ")))

(add-hook 'python-mode-hook
          (lambda()
            (setq mode-name "py")))

(eval-after-load 'javascript-mode
  '(add-hook 'javascript-mode
            (lambda()
              (setq mode-name "js"))))

(eval-after-load 'ruby-mode
  '(add-hook 'ruby-mode
            (lambda()
              (setq mode-name "rb"))))

(eval-after-load 'org-mode
  '(add-hook 'org-mode-hook
            (lambda()
              (setq mode-name "Ω"))))


(provide 'custom-diminish)
;;; custom-diminish.el ends here