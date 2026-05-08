;;; init.el --- Emacs 初期設定  -*- lexical-binding: t -*-

;; パッケージ管理
(require 'package)
(setq package-archives
      '(("gnu"    . "https://elpa.gnu.org/packages/")
        ("melpa"  . "https://melpa.org/packages/")
        ("nongnu" . "https://elpa.nongnu.org/nongnu/")))
(package-initialize)

(unless package-archive-contents
  (package-refresh-contents))

(require 'use-package)
(setq use-package-always-ensure t)
(setq use-package-ensure-function
      (lambda (name args state)
        (condition-case nil
            (use-package-ensure-elpa name args state)
          (error
           (package-refresh-contents)
           (use-package-ensure-elpa name args state)))))

;; 基本設定
(setq inhibit-startup-message t)
(setq initial-scratch-message nil)
(setq ring-bell-function
      (lambda ()
        (let ((orig-fg (face-foreground 'mode-line)))
          (set-face-foreground 'mode-line "red")
          (run-with-timer 0.1 nil
                          (lambda () (set-face-foreground 'mode-line orig-fg))))))

(setq display-line-numbers-type 'relative)
(global-display-line-numbers-mode 1)
(dolist (mode '(vterm-mode-hook
                dashboard-mode-hook))
  (add-hook mode (lambda () (display-line-numbers-mode -1))))

(setq tab-width 4)
(setq-default indent-tabs-mode nil)

(setq backup-by-copying t)
(setq make-backup-files t)
(setq backup-directory-alist '(("." . "~/.emacs.d/backups")))

(setq auto-save-default t)
(setq auto-save-interval 60)
(setq auto-save-timeout 30)
(setq auto-save-file-name-transforms
      `((".*" ,(expand-file-name "auto-save-list/" user-emacs-directory) t)))

(setq-default truncate-lines t)
(global-auto-revert-mode 1)
(show-paren-mode 1)
(setq show-paren-delay 0)
(delete-selection-mode 1)
(recentf-mode 1)
(setq recentf-max-saved-items 200)

(savehist-mode 1)
(setq history-length 300)
(setq savehist-additional-variables '(buffer-name-history))

(use-package vertico
  :init (vertico-mode 1))

(use-package orderless
  :custom
  (completion-styles '(orderless basic))
  (completion-category-overrides '((file (styles basic partial-completion)))))

(use-package marginalia
  :init (marginalia-mode 1))

(use-package consult
  :bind
  ("C-x b"   . consult-buffer)
  ("C-s"     . consult-line)
  ("M-y"     . consult-yank-pop)
  ("C-c r"   . consult-ripgrep)
  ("C-x p b" . consult-project-buffer))

(use-package which-key
  :config (which-key-mode 1))

(use-package magit
  :bind ("C-c g" . magit-status))

(use-package diff-hl
  :config
  (global-diff-hl-mode 1)
  (add-hook 'magit-post-refresh-hook #'diff-hl-magit-post-refresh))

(use-package git-timemachine
  :bind ("C-c t" . git-timemachine))

(use-package dirvish
  :init (dirvish-override-dired-mode))

(setq font-lock-maximum-decoration t)
(mapc (lambda (face)
        (when (facep face)
          (set-face-attribute face nil :weight 'bold)))
      '(font-lock-keyword-face
        font-lock-function-name-face
        font-lock-type-face
        font-lock-builtin-face
        font-lock-constant-face))

;; パッケージ設定
(use-package markdown-mode
  :hook
  (markdown-mode . visual-line-mode)
  (markdown-mode . olivetti-mode)
  (markdown-mode . flyspell-mode)
  (markdown-mode . (lambda ()
                     (font-lock-add-keywords
                      nil
                      '(("<!--\\(.\\|\n\\)*?-->" 0 'font-lock-comment-face t))))))

(use-package olivetti
  :custom (olivetti-body-width 80))

(use-package emojify
  :hook (text-mode . emojify-mode)
  :bind ("C-c e" . emojify-insert-emoji)
  :custom (emojify-display-style 'unicode))

;; Tree-sitter（高精度シンタックスハイライト）
(use-package treesit-auto
  :config (global-treesit-auto-mode))

;; LSP
(use-package eglot
  :hook
  (typescript-ts-mode . eglot-ensure)
  (tsx-ts-mode        . eglot-ensure)
  (web-mode           . eglot-ensure)
  (css-mode           . eglot-ensure)
  (json-ts-mode       . eglot-ensure)
  (yaml-mode          . eglot-ensure)
  (yaml-ts-mode       . eglot-ensure)
  :config
  (add-to-list 'eglot-server-programs
               '(web-mode . ("vscode-html-language-server" "--stdio")))
  (add-to-list 'eglot-server-programs
               '((yaml-mode yaml-ts-mode) . ("yaml-language-server" "--stdio")))
  (add-to-list 'eglot-server-programs
               '((web-mode css-mode) . ("tailwindcss-language-server" "--stdio"))))

;; Web / YAML
(use-package web-mode
  :mode ("\\.html?\\'" "\\.erb\\'"))

(use-package yaml-mode
  :mode "\\.ya?ml\\'")

(use-package dashboard
  :config
  (dashboard-setup-startup-hook)
  (setq dashboard-startup-banner
        (expand-file-name "banner.txt" (expand-file-name ".config/emacs" "~")))
  (setq dashboard-banner-logo-title "Happy Hacking")
  (setq dashboard-center-content t)
  (setq dashboard-show-shortcuts t)
  (setq dashboard-items '((recents  . 8)
                          (bookmarks . 5)
                          (projects . 5)))
  (setq dashboard-footer-messages '("Let the hacking begin!"
                                    "Happy coding!"
                                    "Edit with joy!"))
  (setq dashboard-set-footer t))

(use-package vterm
  :bind ("C-c v" . vterm)
  :config
  (define-key vterm-mode-map (kbd "S-<return>")
    (lambda () (interactive) (vterm-send-key "<return>" t nil nil)))
  (defun my/claude ()
    (interactive)
    (if (get-buffer "*claude*")
        (switch-to-buffer "*claude*")
      (vterm "*claude*")
      (vterm-send-string "claude\n")))
  (global-set-key (kbd "C-c C") #'my/claude))

;; 見た目
(tool-bar-mode -1)
(scroll-bar-mode -1)
(menu-bar-mode 1)
(global-hl-line-mode 1)

(set-frame-font "Hack Nerd Font Mono-22" nil t)
(add-to-list 'default-frame-alist '(font . "Hack Nerd Font Mono-22"))
(set-fontset-font t 'emoji "Apple Color Emoji")

(load-theme 'modus-vivendi t)

;; キーバインド
(global-set-key (kbd "C-h") 'delete-backward-char) ; ヘルプは F1
(global-set-key (kbd "C-z") #'undo)
(global-set-key (kbd "C-x O") (lambda () (interactive) (other-window -1)))

;; 言語・エンコーディング
(prefer-coding-system 'utf-8)
(set-language-environment "Japanese")
(set-default-coding-systems 'utf-8-unix)

;;; init.el ends here
