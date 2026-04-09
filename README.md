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
# 依存ツールのインストール
brew install fish fisher ghq stow

ghq get nawoto/dotfiles
cd ~/ghq/github.com/nawoto/dotfiles
stow .

# fish プラグインを再インストール
fisher update
```

`stow .` が `~/.config` 配下に各ファイルのシンボリックリンクを作成します。
