# 新マシンのセットアップ手順

## フェーズ1: 手動でやること

以下は対話操作が必要なため、手動で実施する。

### 1. Xcode Command Line Tools

```sh
xcode-select --install
```

### 2. SSH キーの生成と GitHub への登録

```sh
ssh-keygen -t ed25519 -C "your@email.com"
cat ~/.ssh/id_ed25519.pub
```

公開鍵を GitHub に登録: https://github.com/settings/ssh/new

### 3. Homebrew

```sh
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
eval "$(/opt/homebrew/bin/brew shellenv)"
```

### 4. 最低限のツールと dotfiles

```sh
brew install fish fisher ghq stow mise
gh auth login
ghq get nawoto/dotfiles
cd ~/Development/github.com/nawoto/dotfiles
stow .
```

### 5. まず入れておくアプリ

```sh
brew install --cask keepingyouawake
```

AquaSKK は Homebrew 未対応のため手動でインストール:

1. https://github.com/codefirst/aquaskk/releases から最新の `.pkg` をダウンロード
2. `.pkg` を実行してインストール
3. システム設定 → キーボード → 入力ソース → AquaSKK を追加

### 6. Ghostty + Claude Code をセットアップ

```sh
brew install --cask ghostty claude-code font-hack-nerd-font
```

Ghostty を起動して動作確認し、Claude Code を実行する。

```sh
claude
```

---

## フェーズ2: Claude Code に任せる

Ghostty で Claude Code を起動し、以下を伝える:

```
~/Development/github.com/nawoto/dotfiles/SETUP.md の
フェーズ3の手順を実行してください。
```

---

## フェーズ3: Claude Code が自動実行する手順

### 7. 残りの Homebrew パッケージ・アプリを一括インストール

```sh
cd ~/Development/github.com/nawoto/dotfiles
brew bundle
```

### 8. fish プラグインをインストール

```sh
fisher update
```

### 9. ランタイムをインストール

```sh
mise install
```

### 10. Emacs 用言語サーバー

```sh
npm install -g typescript-language-server typescript
npm install -g vscode-langservers-extracted
npm install -g yaml-language-server
npm install -g @tailwindcss/language-server
npm install -g @astrojs/language-server
```

---

## フェーズ4: 手動で完了させること

### 11. git の設定

```sh
git config --global user.name "Your Name"
git config --global user.email "your@email.com"
```

### 12. Emacs の初回起動

Emacs を起動するとパッケージが自動インストールされる。完了後:

```
M-x vterm-module-compile
```

vterm のビルドが実行される。
