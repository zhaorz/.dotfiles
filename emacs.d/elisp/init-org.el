;;; org.el
;;;
;;; Richard Zhao
;;;

;;; Code:

(define-key global-map (kbd "C-c c") 'org-capture)
(setq org-export-coding-system 'utf-8)
(setq org-todo-keywords
      '((sequence "TODO" "WAITING" "DONE")))

(setq org-capture-templates
      '(("t" "Todo" entry
         (file+headline "~/Org/todo.org" "Assigned")
         "* TODO %? %U\n  %i\n  %a\n")
        ("j" "Journal" entry
         (file+datetree "~/org/journal.org")
         "* %U %^{Title}\n     %?\n")
        ("n" "Note" entry
         (file+datetree "~/org/notes.org")
         "* %U %^{Title}\n     %?\n")
        ))


(provide 'org)
;;; org.el ends here
