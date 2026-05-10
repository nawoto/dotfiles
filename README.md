# dotfiles

`~/.config` の設定ファイル群。

## セットアップ

```sh
mkdir -p ~/Development/github.com/nawoto
git clone https://github.com/nawoto/dotfiles ~/Development/github.com/nawoto/dotfiles
cd ~/Development/github.com/nawoto/dotfiles
brew bundle
stow .
```

詳細は [SETUP.md](SETUP.md) を参照。

## 管理対象

| パス | 内容 |
|---|---|
| `Brewfile` | Homebrew パッケージ・アプリ一覧 |
| `fish/config.fish` | Fish シェル設定 |
| `fish/fish_plugins` | Fisher プラグイン一覧 |
| `emacs/init.el` | Emacs 設定 |
| `emacs/banner.txt` | Emacs 起動バナー |
| `gh/config.yml` | GitHub CLI 設定 |
| `git/config` | git 設定（ghq root など） |
| `git/ignore` | グローバル gitignore |
| `ghostty/config` | Ghostty 設定 |
| `mise/config.toml` | mise ランタイム設定 |
