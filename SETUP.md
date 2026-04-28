# 新マシンのセットアップ手順

## 1. Xcode Command Line Tools

```sh
xcode-select --install
```

## 2. Homebrew

```sh
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
eval "$(/opt/homebrew/bin/brew shellenv)"
```

## 3. 最低限のツールと dotfiles

```sh
brew install fish fisher ghq stow mise
gh auth login
ghq get nawoto/dotfiles
cd ~/ghq/github.com/nawoto/dotfiles
stow .
```

## 4. まず入れておくアプリ

```sh
brew install --cask aqua-skk keepingyouawake
```

## 5. Ghostty + Claude Code をセットアップ

```sh
brew install --cask ghostty claude-code font-hack-nerd-font
```

Ghostty を起動して動作確認し、Claude Code を実行する。

```sh
claude
```

## 6. 残りの Homebrew パッケージ・アプリを一括インストール

```sh
brew bundle
```

## 7. fish をデフォルトシェルに設定

```sh
echo /opt/homebrew/bin/fish | sudo tee -a /etc/shells
chsh -s /opt/homebrew/bin/fish
```

fish を再起動してから続ける。

## 8. fish プラグインをインストール

```sh
fisher update
```

## 9. ランタイムをインストール

```sh
mise install
```

## 10. Emacs 用言語サーバー

```sh
npm install -g typescript-language-server typescript
npm install -g vscode-langservers-extracted
npm install -g yaml-language-server
npm install -g @tailwindcss/language-server
npm install -g @astrojs/language-server
```

## 11. git の設定

```sh
git config --global user.name "Your Name"
git config --global user.email "your@email.com"
```

## 12. Emacs の初回起動

Emacs を起動するとパッケージが自動インストールされる。完了後:

```
M-x vterm-module-compile
```

vterm のビルドが実行される。
