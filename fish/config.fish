fish_add_path /opt/homebrew/bin
fish_add_path $HOME/.local/bin

mise activate fish | source

set -x FZF_DEFAULT_COMMAND 'rg --files --hidden --follow --glob "!.git/*"'
set -x FZF_FIND_FILE_COMMAND $FZF_DEFAULT_COMMAND

alias ls 'eza -l --git'
alias l  'eza -l --git'
alias la 'eza -la --git'
alias ll 'eza --icons --git --time-style relative -al'

if status is-interactive
    starship init fish | source

    # ↑↓キーで履歴検索
    bind \e\[A history-search-backward
    bind \e\[B history-search-forward
end
