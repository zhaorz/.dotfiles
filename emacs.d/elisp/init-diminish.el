;;; custom-diminish.el
;;;
;;; Richard Zhao
;;;

;;; Code:

(with-eval-after-load 'auto-fill
  (diminish 'auto-fill-function))

(with-eval-after-load 'undo-tree
  (diminish 'undo-tree-mode))

(with-eval-after-load 'auto-revert
  (diminish 'auto-revert-mode))

(add-hook 'emacs-lisp-mode-hook
          (lambda()
            (setq mode-name "λ")))

(add-hook 'term-mode-hook
          (lambda()
            (setq mode-name "τ")))

(add-hook 'python-mode-hook
          (lambda()
            (setq mode-name "py")))

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
