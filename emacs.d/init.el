;; init.el
;;
;; Richard Zhao
;;

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   (quote
    ("b04425cc726711a6c91e8ebc20cf5a3927160681941e06bc7900a5a5bfe1a77f" "a27c00821ccfd5a78b01e4f35dc056706dd9ede09a8b90c6955ae6a390eb1c1e" "d677ef584c6dfc0697901a44b885cc18e206f05114c8a3b7fde674fce6180879" default)))
 '(linum-format (quote dynamic))
 '(org-agenda-files (quote ("~/tmp/notes.org")))
 '(org-hide-leading-stars t)
 '(powerline-display-hud nil)
 '(powerline-height 22)
 '(powerline-text-scale-factor nil)
 '(sml/extra-filler 0)
 '(sml/mode-width (quote full))
 '(sml/name-width 25)
 '(sml/pre-modes-separator (propertize " " (quote face) (quote sml/modes)))
 '(sml/shorten-modes t))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(linum ((t (:background "#eee8d5" :foreground "#93a1a1"))))
 '(sml/modified ((t (:foreground "#b58900" :weight bold)))))

(require 'cl)
(require 'package)
(add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/"))
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))
(add-to-list 'package-archives '("melpa-stable" . "http://stable.melpa.org/packages/"))
(setq package-enable-at-startup nil)
(package-initialize)

;; Vim text editing
(setq evil-want-C-i-jump nil)
(require 'evil)
(evil-mode t)

;; tramp
(require 'tramp)
(setq tramp-default-method "ssh")


;; Globals
(setq inhibit-startup-message t)
(setq ring-bell-function 'ignore)
(setq-default indent-tabs-mode nil) ; never use tabs
(setq-default tab-width 4)

;; Shell
(require 'multi-term)
(setq multi-term-program "/bin/bash")
(evil-set-initial-state 'term-mode 'emacs)   ;; keep term in emacs mode
(add-hook 'term-mode-hook
          (lambda ()
            (setq term-buffer-maximum-size 4096)))
(add-hook 'term-mode-hook
          (lambda ()
            (add-to-list 'term-bind-key-alist '("M-[" . multi-term-prev))
            (add-to-list 'term-bind-key-alist '("M-]" . multi-term-next))))

(setq explicit-shell-file-name "/bin/bash")
(setq shell-file-name "bash")
(global-set-key [f9] 'multi-term)

;; Visual
(load-theme 'solarized-light t)
(add-to-list 'default-frame-alist
             '(font . "Source Code Pro 11"))
(setq solarized-use-less-bold t)
(setq ns-use-srgb-colorspace nil)

;; No lines over 80 cols
(require 'whitespace)
(setq whitespace-line-column 80) ;; limit line length
(setq whitespace-style '(face lines-tail))
(add-hook 'prog-mode-hook 'whitespace-mode)



;; Autocompletion
(add-hook 'after-init-hook 'global-company-mode)

(require 'key-chord)
(setq key-chord-two-keys-delay 0.2)
(key-chord-define evil-insert-state-map "jk" 'evil-normal-state)
(key-chord-mode 1)
(define-key evil-normal-state-map (kbd ";") 'evil-ex)

(require 'better-defaults)

(require 'helm)
(require 'helm-config)

;; The default "C-x c" is quite close to "C-x C-c", which quits Emacs.
;; Changed to "C-c h". Note: We must set "C-c h" globally, because we
;; cannot change `helm-command-prefix-key' once `helm-config' is loaded.
(global-set-key (kbd "C-c h") 'helm-command-prefix)
(global-unset-key (kbd "C-x c"))

;; rebind tab to run persistent action
(define-key helm-map (kbd "<tab>") 'helm-execute-persistent-action)
(define-key helm-map (kbd "C-i") 'helm-execute-persistent-action)
(define-key helm-map (kbd "C-z")  'helm-select-action)

(when (executable-find "curl")
  (setq helm-google-suggest-use-curl-p t))


(setq helm-split-window-in-side-p           t
      helm-move-to-line-cycle-in-source     t
      helm-ff-search-library-in-sexp        t
      helm-scroll-amount                    8
      helm-ff-file-name-history-use-recentf t)

(helm-mode 1)

(global-set-key (kbd "M-x") 'helm-M-x)
(global-set-key (kbd "C-x C-f") 'helm-find-files)
(global-set-key (kbd "C-x b") 'helm-mini)

(define-key evil-ex-map "e " 'helm-find-files)
(define-key evil-ex-map "b " 'helm-buffers-list)

;; Scroll with C-j/C-k
(define-key evil-normal-state-map (kbd "C-k") (lambda ()
                                                (interactive)
                                                (evil-scroll-up 15)
                                                ))
(define-key evil-normal-state-map (kbd "C-j") (lambda ()
                                                (interactive)
                                                (evil-scroll-down 15)
                                                ))

;; Switch windows faster
(windmove-default-keybindings)
(global-set-key (kbd "M-h") 'evil-window-left)
(global-set-key (kbd "M-j") 'evil-window-down)
(global-set-key (kbd "M-k") 'evil-window-up)
(global-set-key (kbd "M-l") 'evil-window-right)

(add-hook 'before-save-hook 'delete-trailing-whitespace)

;; diminish
(when (require 'diminish nil 'noerror)
  (diminish 'undo-tree-mode)
  (diminish 'whitespace-mode)
  (eval-after-load "company"
      '(diminish 'company-mode))
  (eval-after-load "helm"
      '(diminish 'helm-mode))
  (eval-after-load "helm-config"
      '(diminish 'helm-mode))
  )

(add-hook 'emacs-lisp-mode-hook
  (lambda()
    (setq mode-name "λ")))

(add-hook 'term-mode-hook
  (lambda()
    (setq mode-name "τ")))

(add-hook 'python-mode-hook
  (lambda()
    (setq mode-name "py")))

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
(global-set-key (kbd "C-x g") 'magit-status)

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

(require 'powerline)
(powerline-custom-theme)
(setq powerline-default-separator 'slant)       ;; mirrored diagonals
