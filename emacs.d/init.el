;;; init.el
;;;
;;; Richard Zhao
;;;

; list the packages you want
(setq package-list
      '(use-package diminish exec-path-from-shell evil
                    projectile helm multi-term tramp
                    whitespace company yasnippet
                    key-chord emmet-mode web-mode
                    company-web solarized-theme zenburn-theme
                    org-bullets markdown-mode
                    hydra powerline
                    magit slim-mode
                    haskell-mode ghc company-ghc
                    rjsx-mode
        ))

(require 'package)
(add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/"))
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))
(add-to-list 'package-archives '("melpa-stable" . "http://stable.melpa.org/packages/"))
(add-to-list 'load-path "~/.emacs.d/plugins/")
(setq package-enable-at-startup nil)
(package-initialize)

; fetch the list of packages available
(unless package-archive-contents
  (package-refresh-contents))

; install the missing packages
(dolist (package package-list)
  (unless (package-installed-p package)
    (package-install package)))

(setq custom-file "~/.emacs.d/custom.el")
(load custom-file)

(eval-when-compile
  (require 'use-package))
(require 'diminish)

(load-file "~/.emacs.d/elisp/init-globals.el")
(load-file "~/.emacs.d/elisp/init-org.el")
(load-file "~/.emacs.d/elisp/init-visual.el")
(load-file "~/.emacs.d/elisp/init-diminish.el")
(load-file "~/.emacs.d/elisp/init-modeline.el")

(setenv "ESHELL" (expand-file-name "~/bin/eshell"))

(use-package exec-path-from-shell
  :config
  (exec-path-from-shell-copy-env "GOPATH")
  (exec-path-from-shell-initialize))

(use-package evil
  :init
  (setq evil-want-C-i-jump nil)
  :config
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
  (define-key evil-normal-state-map (kbd ";") 'evil-ex)

  (global-set-key (kbd "M-h") 'evil-window-left)
  (global-set-key (kbd "M-j") 'evil-window-down)
  (global-set-key (kbd "M-k") 'evil-window-up)
  (global-set-key (kbd "M-l") 'evil-window-right)

  (evil-mode t))

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
                                         (projectile-project-name))))))

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
         ("b" . helm-buffers-list)))

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
              (add-to-list 'term-bind-key-alist '("M-]" . multi-term-next)))))

(use-package tramp
  :defer t
  :config
  (setq tramp-default-method "ssh"))

(use-package whitespace
  :diminish whitespace-mode
  :config
  (setq whitespace-line-column 80) ; limit line length
  ;; (setq whitespace-style '(face lines-tail))
  (setq whitespace-style 'nil)
  (add-hook 'prog-mode-hook 'whitespace-mode))

(use-package company
  :diminish company-mode
  :ensure t
  :defer 2
  :config
  (setq company-idle-delay 0.3)
  (add-to-list 'company-backends 'company-tern)
  (add-to-list 'company-backends 'company-ghc)
  (global-company-mode))

(use-package yasnippet
  :diminish yas-minor-mode
  :config
  (add-to-list 'yas-snippet-dirs "~/.emacs.d/yasnippet-snippets")
  (yas-global-mode 1))

;; (use-package flycheck
;;   :diminish "ƒ✓"
;;   :ensure t
;;   :init (global-flycheck-mode)
;;   :config
;;   ;; blacklist
;;   ;; (setq flycheck-global-modes '(not haskell-mode))
;;   (setq flycheck-display-errors-delay 0.1)
;;   (setq-default flycheck-disabled-checkers
;;                 (append flycheck-disabled-checkers
;;                         '(javascript-jshint))))

(use-package key-chord
  :config
  (setq key-chord-two-keys-delay 0.2)
  (key-chord-define evil-insert-state-map "jk" 'evil-normal-state)
  (key-chord-mode 1))

(use-package emmet-mode
  :diminish (emmet-mode . " Σ")
  :config
  (add-hook 'sgml-mode-hook 'emmet-mode)
  (add-hook 'css-mode-hook  'emmet-mode)
  (add-hook 'web-mode-hook  'emmet-mode))

(use-package rjsx-mode
  :config
  (add-to-list 'auto-mode-alist '("\\.js\\'" . rjsx-mode))
  (add-to-list 'auto-mode-alist '("\\.jsx?\\'" . rjsx-mode)))

(use-package web-mode
  :config
  (add-to-list 'auto-mode-alist '("\\.erb\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.css\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.scss\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode))

  (setq web-mode-markup-indent-offset 2)
  (setq web-mode-css-indent-offset 2)
  (setq web-mode-code-indent-offset 2)
  (setq-default js-indent-level 2)
  (use-package company-web
    :config
    (use-package company-web-html)
    (add-hook 'web-mode-hook
              (lambda ()
                (set (make-local-variable 'company-backends) '(company-web-html))
                (company-mode t)))))

(use-package org-bullets-mode
  :diminish
  :config
  (add-hook 'org-mode-hook (lambda () (org-bullets-mode 1))))

(use-package markdown-mode
  :ensure t
  :commands (markdown-mode gfm-mode)
  :mode (("README\\.md\\'" . gfm-mode)
         ("\\.md\\'" . markdown-mode)
         ("\\.markdown\\'" . markdown-mode))
  :init (setq markdown-command "multimarkdown"))

(use-package magit
  :bind (("C-x g" . magit-status)))

(use-package slim-mode
  :config
  (add-to-list 'auto-mode-alist '("\\.slim\\'" . slim-mode))
  )

(use-package go-mode
  :config
  (setenv "GOPATH" "/Users/rzhao/workspace/go")
  (add-hook 'before-save-hook 'gofmt-before-save)
  )

(use-package ghc
  :config
  (autoload 'ghc-init "ghc" nil t)
  (autoload 'ghc-debug "ghc" nil t)
  (add-hook 'haskell-mode-hook (lambda () (ghc-init)))
  )

(use-package tutch-mode
  :mode ("\\.tut\\'" . tutch-mode))

(load-file "~/.emacs.d/elisp/init-hydra.el")

(provide 'init)
;;; init.el ends here
