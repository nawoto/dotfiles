;;; init.el --- Emacs 初期設定

;; -----------------------------------------------------------------------------
;; パッケージ管理（初回は M-x package-refresh-contents を実行）
;; -----------------------------------------------------------------------------
(require 'package)
(setq package-archives
      '(("gnu"    . "https://elpa.gnu.org/packages/")
        ("melpa"  . "https://melpa.org/packages/")
        ("nongnu" . "https://elpa.nongnu.org/nongnu/")))
(package-initialize)

;; use-package がなければインストール（推奨）
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))
(require 'use-package)
(setq use-package-always-ensure t)

;; -----------------------------------------------------------------------------
;; 基本設定
;; -----------------------------------------------------------------------------

;; 起動時は dashboard を表示（下で設定）
(setq inhibit-startup-message t)
(setq initial-scratch-message nil)

;; 行番号（absolute=絶対, relative=相対, nil=非表示）
(setq display-line-numbers-type 'relative)
(global-display-line-numbers-mode 1)

;; タブ・インデント
(setq tab-width 4)
(setq-default indent-tabs-mode nil) ; タブの代わりにスペース

;; バックアップファイル
(setq backup-by-copying t)
(setq make-backup-files t)
(setq backup-directory-alist '(("." . "~/.emacs.d/backups")))

;; 自動保存（編集中ファイルを定期的に保存）
(setq auto-save-default t)
(setq auto-save-interval 60)       ; 60打鍵ごと
(setq auto-save-timeout 30)        ; 30秒アイドルで保存

;; 行折り返し（t=する, nil=しない）
(setq-default truncate-lines t)

;; 対応する括弧をハイライト
(show-paren-mode 1)
(setq show-paren-style 'parenthesis)

;; 構文強調を派手に（1=控えめ, 2=標準+, 3=最大 / t=可能な限り最大）
(setq font-lock-maximum-decoration t)

;; キーワード・関数名・型などを太字で目立たせる
(mapc (lambda (face)
        (when (facep face)
          (set-face-attribute face nil :weight 'bold)))
      '(font-lock-keyword-face
        font-lock-function-name-face
        font-lock-type-face
        font-lock-builtin-face
        font-lock-constant-face))

;; markdown-mode: HTML コメント <!-- --> をコメント色に
(use-package markdown-mode
  :ensure t
  :hook (markdown-mode . (lambda ()
                           (font-lock-add-keywords
                            nil
                            '(("<!--\\(.\\|\n\\)*?-->" 0 'font-lock-comment-face t))))))

;; 選択範囲に上書き入力
(delete-selection-mode 1)

;; 最近開いたファイルを記録
(recentf-mode 1)
(setq recentf-max-saved-items 200)

;; ミニバッファ履歴を保存（バッファ切り替え履歴も維持）
(savehist-mode 1)
(setq history-length 300)
(setq savehist-additional-variables '(buffer-name-history))

;; C-x b などのバッファ切り替えをインクリメンタル検索化
(ido-mode 1)
(ido-everywhere 1)
(setq ido-enable-flex-matching t)     ; 部分一致を許可
(setq ido-use-virtual-buffers t)      ; 最近使ったバッファ/履歴候補を表示

;; -----------------------------------------------------------------------------
;; 起動画面（dashboard）
;; -----------------------------------------------------------------------------
(use-package dashboard
  :config
  (dashboard-setup-startup-hook)
  ;; 派手なバナー: banner.txt（nawo.to 風）を使う。使わない場合は 3 にすると組み込みバナー
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

;; -----------------------------------------------------------------------------
;; 見た目
;; -----------------------------------------------------------------------------

;; ツールバー・スクロールバーを非表示（すっきりさせる場合）
(tool-bar-mode -1)
(scroll-bar-mode -1)
(menu-bar-mode 1)   ; メニューは 1 で表示、-1 で非表示

;; フォント（Cursor に合わせて Menlo 22pt / Cursor の editor.fontSize: 22, fontFamily 未設定時）
(set-frame-font "Menlo-22" nil t)
(add-to-list 'default-frame-alist '(font . "Menlo-22"))

;; テーマ（built-in: modus-vivendi=暗い, modus-operandi=明るい）
;; 外部テーマを使う場合は package-install でインストール後に load-theme
(load-theme 'modus-vivendi t)   ; 暗いテーマ
;; (load-theme 'modus-operandi t) ; 明るいテーマ

;; カーソル行をハイライト（オプション）
(global-hl-line-mode 1)

;; -----------------------------------------------------------------------------
;; キーバインド
;; -----------------------------------------------------------------------------

;; C-h を Backspace（後退削除）に（ヘルプは F1 で可能）
(global-set-key (kbd "C-h") 'delete-backward-char)

;; C-z でアンドゥ（既定の suspend-frame は C-x C-z などで可能）
(global-set-key (kbd "C-z") #'undo)

;; C-x C-b でバッファリスト
(global-set-key (kbd "C-x C-b") 'buffer-menu)

;; 行末の空白を保存時に削除（好みで有効化）
;; (add-hook 'before-save-hook 'delete-trailing-whitespace)

;; -----------------------------------------------------------------------------
;; 言語・エンコーディング
;; -----------------------------------------------------------------------------
(prefer-coding-system 'utf-8)
(set-language-environment "Japanese")
(set-default-coding-systems 'utf-8-unix)

;; -----------------------------------------------------------------------------
;; eat（ターミナルエミュレータ）
;; -----------------------------------------------------------------------------
(use-package eat
  :ensure t
  ;; Eshell 内で eat のターミナルエミュレータを使う
  :hook (eshell-mode . eat-eshell-mode)
  :bind
  ;; C-c t で eat ターミナルを開く
  ("C-c t" . eat))

;;; init.el ends here
