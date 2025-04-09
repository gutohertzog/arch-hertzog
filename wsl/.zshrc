# inicia o ambiente virtual do python com o terminal
source $HOME/.venv/bin/activate

# roda fastfetch
fastfetch

# ativa p10k
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# -------------------------------------------------------------------------------------------------
# definições do oh-my-zsh
export ZSH="$HOME/.oh-my-zsh"

# define o tema para carregar
# mais em : https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="powerlevel10k/powerlevel10k"

CASE_SENSITIVE="false"
HYPHEN_INSENSITIVE="false"
HIST_STAMPS="yyyy-mm-dd"

# comportamento do auto update
zstyle ':omz:update' mode disabled  # desativa atualização
# zstyle ':omz:update' mode auto      # atualiza automaticamente
# zstyle ':omz:update' mode reminder  # lembra a cada X dias

# intervalo de atualização em dias
# zstyle ':omz:update' frequency 13

plugins=(git fzf-tab zsh-completions zsh-autosuggestions zsh-syntax-highlighting)
source $ZSH/oh-my-zsh.sh

# histórico
HISTSIZE=5000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

# -------------------------------------------------------------------------------------------------
# aliases
alias zshconfig="vim ~/.zshrc"
alias canos="$HOME/GitHub/pipes.sh/pipes.sh"
alias src="source ~/.zshrc" # recarrega o .zshrc
alias pst="ls -lah | grep ^drw"
alias arq="ls -lah | grep ^-rw"
alias pfless="fzf --preview='less {}' --bind up:preview-page-up,down:preview-page-down"
alias pfbat="fzf --preview 'bat --style=numbers --color=always --line-range :500 {}'"
alias vim="vim -S ~/.config/vim/vimrc"
alias ls="eza --sort extension"
alias ff="fastfetch"
# alias cdf="cd './$(find -type d | fzf)'"

# alias do pacman
alias orfaos="pacman -Qtd"
alias remove_orfaos="sudo pacman -Runs $(pacman -Qdt)"
alias instalados="pacman -Qe"
alias update="sudo pacman -Suvy && yay -Suvy"
alias limpa_tudo="sudo pacman -Scc && yay -Scc"

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# atalhos
bindkey '^k' history-search-backward
bindkey '^j' history-search-forward

# integrações do shell
eval "$(zoxide init --cmd cd zsh)"
eval "$(fzf --zsh)"

# cores para fzf
export FZF_DEFAULT_OPTS='
  --color=bg+:#313244,bg:#1e1e2e,spinner:#f5e0dc,hl:#f38ba8
  --color=fg:#cdd6f4,header:#f38ba8,info:#cba6f7,pointer:#f5e0dc
  --color=marker:#f5e0dc,fg+:#cdd6f4,prompt:#cba6f7,hl+:#f38ba8
'

export EZA_ICONS_AUTO='always'
