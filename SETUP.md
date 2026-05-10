# 新マシンのセットアップ手順

## 1. Xcode Command Line Tools

```sh
xcode-select --install
```

## 2. Homebrew

```sh
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
eval "$(/opt/homebrew/bin/brew shellenv)"
echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
```

## 3. dotfiles を clone して環境を構築

```sh
mkdir -p ~/Development/github.com/nawoto
git clone https://github.com/nawoto/dotfiles ~/Development/github.com/nawoto/dotfiles
cd ~/Development/github.com/nawoto/dotfiles
brew bundle
stow .
```

`stow .` は `~/.config` 配下に既存ファイルがあると競合してエラーになる。その場合は該当ファイルを削除してから再実行する。

## 4. SSH キーの生成と GitHub への登録

```sh
ssh-keygen -t ed25519 -C "your@email.com"
cat ~/.ssh/id_ed25519.pub
```

公開鍵を GitHub に登録: https://github.com/settings/ssh/new

## 5. GitHub CLI の認証

```sh
gh auth login
```

## 6. fish プラグインをインストール

Ghostty を起動すると fish が立ち上がる。その状態で:

```sh
fisher update
```

## 7. ランタイムをインストール

```sh
mise install
```

## 8. Emacs 用言語サーバー

```sh
npm install -g typescript-language-server typescript
npm install -g vscode-langservers-extracted
npm install -g yaml-language-server
npm install -g @tailwindcss/language-server
```

## 9. AquaSKK のインストール

AquaSKK は Homebrew 未対応のため手動でインストール:

1. https://github.com/codefirst/aquaskk/releases から最新の `.pkg` をダウンロード
2. `.pkg` を実行してインストール
3. システム設定 → キーボード → 入力ソース → AquaSKK を追加

## 10. git の設定

```sh
git config --global user.name "Your Name"
git config --global user.email "your@email.com"
```

## 11. 各アプリのサインイン

- **Slack**: 起動してサインイン
- **Dropbox**: 起動してサインインし、同期フォルダを設定
- **Google Chrome**: 起動して Google アカウントでサインインし、ブックマーク等を同期

## 12. Emacs の初回起動

Emacs を起動するとパッケージが自動インストールされる。完了後:

```
M-x vterm-module-compile
```

vterm のビルドが実行される。
