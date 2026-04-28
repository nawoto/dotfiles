# dotfiles

`~/.config` の設定ファイル群。

## 管理対象

| パス | 内容 |
|---|---|
| `fish/config.fish` | Fish シェル設定 |
| `fish/fish_plugins` | Fisher プラグイン一覧 |
| `emacs/init.el` | Emacs 設定 |
| `emacs/banner.txt` | Emacs 起動バナー |
| `gh/config.yml` | GitHub CLI 設定 |
| `git/ignore` | グローバル gitignore |

## 新マシンでのセットアップ

```sh
# 1. 最低限必要なツールをインストールして dotfiles を clone
brew install fish fisher ghq stow mise
ghq get nawoto/dotfiles
cd ~/ghq/github.com/nawoto/dotfiles

# 2. dotfiles を ~/.config に symlink
stow .

# 3. Homebrew パッケージ・アプリを一括インストール
brew bundle

# 4. fish を default shell に設定
echo /opt/homebrew/bin/fish | sudo tee -a /etc/shells
chsh -s /opt/homebrew/bin/fish

# 5. fish プラグインを再インストール
fisher update

# 6. ランタイムをインストール（mise 経由）
mise install

# 7. Emacs 用言語サーバー
npm install -g typescript-language-server typescript
npm install -g vscode-langservers-extracted
npm install -g yaml-language-server
npm install -g @tailwindcss/language-server
npm install -g @astrojs/language-server
```

`stow .` が `~/.config` 配下に各ファイルのシンボリックリンクを作成します。
