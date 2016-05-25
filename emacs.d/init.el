;;; init.el
;;;
;;; Richard Zhao
;;;

(require 'package)
(add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/"))
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))
(add-to-list 'package-archives '("melpa-stable" . "http://stable.melpa.org/packages/"))
(setq package-enable-at-startup nil)
(package-initialize)

(setq custom-file "~/.emacs.d/custom.el")
(load custom-file)

(eval-when-compile
  (require 'use-package))
(require 'diminish)

(use-package evil
  :init
  (setq evil-want-C-i-jump nil)
  :config
  (evil-mode t)
  (evil-set-initial-state 'term-mode 'emacs)

  (define-key evil-normal-state-map (kbd "C-k") (lambda ()
                                                  (interactive)
                                                  (evil-scroll-up 15)
                                                  ))
  (define-key evil-normal-state-map (kbd "C-j") (lambda ()
                                                  (interactive)
                                                  (evil-scroll-down 15)
                                                  ))
  (define-key evil-normal-state-map (kbd "C-n") 'next-line)
  (define-key evil-normal-state-map (kbd "C-p") 'previous-line)
  (define-key evil-normal-state-map (kbd ";") 'evil-ex))

(use-package projectile
  :config
  (projectile-global-mode)
  (setq projectile-completion-system 'helm
        projectile-enable-caching t
        projectile-mode-line '(:eval
                               (if
                                   (file-remote-p default-directory)
                                   " Projectile"
                                 (format " ρ[%s]"
                                         (projectile-project-name))))
       )
  )

(use-package helm
  :diminish helm-mode
  :init
  (progn
    (require 'helm-config)
    (helm-mode 1)

    (setq helm-split-window-in-side-p           t
          helm-move-to-line-cycle-in-source     t
          helm-scroll-amount                    8)
    )
  :bind (
         ("M-x" . helm-M-x)
         ("C-x C-f" . helm-find-files)
         ("C-x b" . helm-mini)
         :map evil-ex-map
         ("e" . helm-find-files)
         ("b" . helm-buffers-list)
         )
  )


(use-package multi-term
  :bind (([f9] . multi-term))
  :config
  (setq multi-term-program "/bin/bash")
  (add-hook 'term-mode-hook
            (lambda ()
              (setq term-buffer-maximum-size 4096)))
  (add-hook 'term-mode-hook
            (lambda ()
              (add-to-list 'term-bind-key-alist '("M-[" . multi-term-prev))
              (add-to-list 'term-bind-key-alist '("M-]" . multi-term-next))))
  )

(use-package tramp
  :defer t
  :config
  (setq tramp-default-method "ssh"))

;; Globals
(setq inhibit-startup-message t)
(setq ring-bell-function 'ignore)
(setq-default indent-tabs-mode nil) ; never use tabs
(setq-default tab-width 4)
(setq show-paren-delay 0)
(show-paren-mode 1)

(setq explicit-shell-file-name "/bin/bash")
(setq shell-file-name "bash")

;; Visual
(load-theme 'solarized-light t)
(add-to-list 'default-frame-alist
             '(font . "Source Code Pro 11"))
(setq ns-use-srgb-colorspace nil) ; fix weird colors in powerline

(use-package whitespace
  :diminish whitespace-mode
  :config
  (setq whitespace-line-column 80) ; limit line length
  (setq whitespace-style '(face lines-tail))
  (add-hook 'prog-mode-hook 'whitespace-mode)
  )

(use-package company
  :diminish company-mode
  :ensure t
  :defer 2
  :config
  (setq company-idle-delay 0.3)
  (global-company-mode))

(use-package yasnippet
  :diminish yas-minor-mode
  :config
  (add-to-list 'yas-snippet-dirs "~/.emacs.d/yasnippet-snippets")
  (yas-global-mode 1)
  )

(use-package flycheck
  :diminish "ƒ✓"
  :ensure t
  :init (global-flycheck-mode)
  :config (setq flycheck-display-errors-delay 0.1))

(use-package key-chord
  :config
  (setq key-chord-two-keys-delay 0.2)
  (key-chord-define evil-insert-state-map "jk" 'evil-normal-state)
  (key-chord-mode 1)
  )

(use-package emmet-mode
  :config
  (add-hook 'sgml-mode-hook 'emmet-mode)
  (add-hook 'css-mode-hook  'emmet-mode)
  (add-hook 'web-mode-hook  'emmet-mode)
  )

(use-package web-mode
  :config
  (add-to-list 'auto-mode-alist '("\\.erb\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode))

  (setq web-mode-markup-indent-offset 2)
  (setq web-mode-css-indent-offset 2)
  (setq web-mode-code-indent-offset 2)
  )

(add-hook 'before-save-hook 'delete-trailing-whitespace)

(global-set-key (kbd "M-h") 'evil-window-left)
(global-set-key (kbd "M-j") 'evil-window-down)
(global-set-key (kbd "M-k") 'evil-window-up)
(global-set-key (kbd "M-l") 'evil-window-right)

;; diminish
(diminish 'auto-fill-function)
(diminish 'undo-tree-mode)
(diminish 'auto-revert-mode)

(add-hook 'prog-mode-hook 'turn-on-auto-fill)

(add-hook 'emacs-lisp-mode-hook
          (lambda()
            (setq mode-name "λ")))

(add-hook 'term-mode-hook
          (lambda()
            (setq mode-name "τ")))

(add-hook 'python-mode-hook
          (lambda()
            (setq mode-name "py")))

(add-hook 'javascript-mode
          (lambda()
            (setq mode-name "js")))

(add-hook 'ruby-mode
          (lambda()
            (setq mode-name "rb")))

(add-hook 'org-mode-hook
          (lambda()
            setq mode-name "Ω"))

(add-hook 'org-mode-hook
          (lambda()
            (auto-fill-mode t)))

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

;; magit
(use-package magit
  :bind (("C-x g" . magit-status))
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

(provide 'init)
;;; init.el ends here
