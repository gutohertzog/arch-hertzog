# inicia o ambiente virtual do python com o terminal
source $HOME/.venv/bin/activate

# Change with your fetcher
FETCHER="fastfetch"

FETCHER_HEIGHT=$((($($FETCHER | wc -l) + 1) / 2))

# Extra settings
EXTRA_PADDING_H=2
EXTRA_PADDING_W=0

# Room for the sprite
WIDTH=38

# Gets a sprite via pokeget
sprite=$("$HOME/Apps/pokeget" kanto --hide-name)

# Gets sprite's height
height=$(echo "$sprite" | wc -l)

# Pad for vertical centering
pad_top=$((($FETCHER_HEIGHT - $height) / 2))
pad_top=$((pad_top + EXTRA_PADDING_H))

# Just for safety
if [ $pad_top -lt 0 ]; then
  pad_top=0
fi

# Gets sprite's sprite_width
sprite_width=0

# Iters sprite's lines
while IFS= read -r line; do
  # Gets line's width
  line_w=${#line}
  # Compare and Update sprite_width
  if ((line_w > sprite_width)); then
    sprite_width=$line_w
  fi
done <<<"$sprite"

# Real sprite_width (idk why the other is scaled)
sprite_width=$(((sprite_width + 35 - 1) / 35))

# Calculate the lateral padding
pad_lat=$((($WIDTH - sprite_width) / 2))
pad_lat=$((pad_lat + EXTRA_PADDING_W))

# Just for safety
if [ $pad_lat -lt 0 ]; then
  pad_lat=0
fi

# this may not work for your fetcher, check them all
echo "$sprite" | $FETCHER --file-raw - --logo-padding-top $pad_top --logo-padding-left $pad_lat --logo-padding-right $pad_lat

# ativa p10k
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# -------------------------------------------------------------------------------------------------
# troca o local de alguns arquivos gerados automaticamente
# muda o local do .zcompdump
export ZSH_COMPDUMP=$HOME/.cache/.zcompdump-$HOST

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
# alias vim="vim -S ~/.config/vim/vimrc"
alias ls="eza --sort extension"
alias ff="fastfetch"
# alias cdf="cd './$(find -type d | fzf)'"

# alias do pacman
alias orfaos="pacman -Qtd"
alias remove_orfaos="sudo pacman -Runs $(pacman -Qdt)"
alias instalados="pacman -Qe"
alias update="sudo pacman -Suvy && yay -Suvy"
alias limpa_tudo="sudo pacman -Scc && yay -Scc"

# alias sqlcmd
alias sqlcmd='/mnt/c/Program\ Files/Microsoft\ SQL\ Server/Client\ SDK/ODBC/170/Tools/Binn/SQLCMD.exe'

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
