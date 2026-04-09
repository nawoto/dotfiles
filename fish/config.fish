set -gx PATH $PATH /opt/homebrew/bin

starship init fish | source

if status is-interactive
    # Commands to run in interactive sessions can go here
end

set -x FZF_DEFAULT_COMMAND 'rg --files --hidden --follow --glob "!.git/*"'
set -x FZF_LEGACY_KEYBINDINGS 1
set -x FZF_FIND_FILE_COMMAND $FZF_DEFAULT_COMMAND

alias ls 'eza -l --git'
alias l 'eza -l --git'
alias la 'eza -la --git'
alias ll 'eza --icons --git --time-style relative -al'
set -gx VOLTA_HOME "$HOME/.volta"
set -gx PATH "$VOLTA_HOME/bin" $PATH

# ↑↓キーで履歴検索（現行fish対応版）
bind \e\[A history-search-backward
bind \e\[B history-search-forward
fish_add_path $HOME/.local/bin
