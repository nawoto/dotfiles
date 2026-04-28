fish_add_path /opt/homebrew/bin
fish_add_path $HOME/.local/bin

mise activate fish | source

set -gx FZF_DEFAULT_COMMAND 'rg --files --hidden --follow --glob "!.git/*"'

zoxide init fish | source

alias ls 'eza -l --git'
alias l  'eza -l --git'
alias la 'eza -la --git'
alias ll 'eza --icons --git --time-style relative -al'

if status is-interactive
    starship init fish | source
    fzf_configure_bindings --directory=\cf

    # ↑↓キーで履歴検索
    bind up history-search-backward
    bind down history-search-forward
end
