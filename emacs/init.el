;;; init.el --- Emacs 初期設定

;; パッケージ管理
(require 'package)
(setq package-archives
      '(("gnu"    . "https://elpa.gnu.org/packages/")
        ("melpa"  . "https://melpa.org/packages/")
        ("nongnu" . "https://elpa.nongnu.org/nongnu/")))
(package-initialize)

(unless package-archive-contents
  (package-refresh-contents))

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))
(require 'use-package)
(setq use-package-always-ensure t)

;; 基本設定
(setq inhibit-startup-message t)
(setq initial-scratch-message nil)

(setq display-line-numbers-type 'relative)
(global-display-line-numbers-mode 1)

(setq tab-width 4)
(setq-default indent-tabs-mode nil)

(setq backup-by-copying t)
(setq make-backup-files t)
(setq backup-directory-alist '(("." . "~/.emacs.d/backups")))

(setq auto-save-default t)
(setq auto-save-interval 60)
(setq auto-save-timeout 30)

(setq-default truncate-lines t)
(show-paren-mode 1)
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
  ("C-c r"   . consult-ripgrep))

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
  :hook (markdown-mode . (lambda ()
                           (font-lock-add-keywords
                            nil
                            '(("<!--\\(.\\|\n\\)*?-->" 0 'font-lock-comment-face t))))))

(use-package dashboard
  :config
  (dashboard-setup-startup-hook)
  (setq dashboard-startup-banner
        (expand-file-name "banner.txt" (expand-file-name ".config/emacs" "~")))
  (setq dashboard-banner-logo-title "✨ ようこそ Emacs へ ✨")
  (setq dashboard-center-content t)
  (setq dashboard-show-shortcuts t)
  (setq dashboard-set-navigator t)
  (setq dashboard-items '((recents  . 8)
                          (bookmarks . 5)
                          (projects . 5)))
  (setq dashboard-footer-messages '("Let the hacking begin!"
                                    "Happy coding!"
                                    "編集を楽しもう！"))
  (setq dashboard-set-footer t))

(use-package eat
  :hook (eshell-mode . eat-eshell-mode)
  :bind ("C-c t" . eat))

;; 見た目
(tool-bar-mode -1)
(scroll-bar-mode -1)
(menu-bar-mode 1)
(global-hl-line-mode 1)

(set-frame-font "Menlo-22" nil t)
(add-to-list 'default-frame-alist '(font . "Menlo-22"))

(load-theme 'modus-vivendi t)

;; キーバインド
(global-set-key (kbd "C-h") 'delete-backward-char) ; ヘルプは F1
(global-set-key (kbd "C-z") #'undo)
(global-set-key (kbd "C-x C-b") 'buffer-menu)
(global-set-key (kbd "C-x O") (lambda () (interactive) (other-window -1)))

;; 言語・エンコーディング
(prefer-coding-system 'utf-8)
(set-language-environment "Japanese")
(set-default-coding-systems 'utf-8-unix)

;;; init.el ends here
