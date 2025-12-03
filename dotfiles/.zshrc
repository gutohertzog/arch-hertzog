# inicia o ambiente virtual do python com o terminal
source $HOME/.venv/bin/activate

# executa fastfetch
# fastfetch

# by discomanfulanito,
# for everyone — as code should be

# Sprites are drawn from here
POKEMON_LIST=(
  bulbasaur
  squirtle
  charmander
  pikachu
)

# Change with your fetcher
FETCHER="fastfetch"

FETCHER_HEIGHT=$((($($FETCHER | wc -l) + 1) / 2))

# Extra settings
EXTRA_PADDING_H=2
EXTRA_PADDING_W=0

# Room for the sprite
WIDTH=38

# Gets a sprite via pokeget
random_index=$(( RANDOM % ${#POKEMON_LIST[@]} + 1 ))
# sprite=$("$HOME/Apps/pokeget" "${POKEMON_LIST[random_index]}" --hide-name)
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

# comportamento do auto update
zstyle ':omz:update' mode disabled  # desativa atualização
# zstyle ':omz:update' mode auto      # atualiza automaticamente
# zstyle ':omz:update' mode reminder  # lembra a cada X dias

# intervalo de atualização em dias
# zstyle ':omz:update' frequency 13

HIST_STAMPS="yyyy-mm-dd"

plugins=(git fzf-tab zsh-completions zsh-autosuggestions zsh-syntax-highlighting)

source $ZSH/oh-my-zsh.sh

# histórico
HISTSIZE=5000
HISTFILE=$HOME/.cache/.zsh_history
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
alias cpd="sudo openvpn --config ~/Documents/vpn-cpd-v1.1.ovpn"
alias pst="ls -lah | grep ^drw"
alias arq="ls -lah | grep ^-rw"
alias pfless="fzf --preview='less {}' --bind up:preview-page-up,down:preview-page-down"
alias pfbat="fzf --preview 'bat --style=numbers --color=always --line-range :500 {}'"
alias vim="vim -S ~/.config/vim/vimrc"
alias ls="eza --sort type"
alias ff="fastfetch"

# controle dos leds da gpu
alias gpu_100="nvidia-settings --assign GPULogoBrightness=100 >> /dev/null"
alias gpu_0="nvidia-settings --assign GPULogoBrightness=0 >> /dev/null"

# alias do pacman
alias orfaos="pacman -Qtd"
alias remove_orfaos="sudo pacman -Runs $(pacman -Qdt)"
alias instalados="pacman -Qe"
# alias cdf="cd './$(find -type d | fzf)'"

# alias para o kitty
# alias kitty="kitty --override background_image=\$(ls /home/guto/Pictures/wallpapers/*.png | sort --random-sort | head -1)"

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# atalhos
bindkey '^k' history-search-backward
bindkey '^j' history-search-forward

# integrações do shell
eval "$(zoxide init --cmd cd zsh)"
eval "$(fzf --zsh)"

# cores para o fzf catppuccin-fzf-mocha
export FZF_DEFAULT_OPTS=" \
--color=bg+:#313244,bg:#1E1E2E,spinner:#F5E0DC,hl:#F38BA8 \
--color=fg:#CDD6F4,header:#F38BA8,info:#CBA6F7,pointer:#F5E0DC \
--color=marker:#B4BEFE,fg+:#CDD6F4,prompt:#CBA6F7,hl+:#F38BA8 \
--color=selected-bg:#45475A \
--color=border:#6C7086,label:#CDD6F4"
  #--color=dark
  #--color=fg:-1,bg:-1,hl:#c678dd,fg+:#ffffff,bg+:#4b5263,hl+:#d858fe
  #--color=info:#98c379,prompt:#61afef,pointer:#be5046,marker:#e5c07b,spinner:#61afef,header:#61afef

export EZA_ICONS_AUTO='always'

# adiciona o código abaixo no .zshrc na última linha para desativar arrumar a cor das pastas
export LS_COLORS='rs=0:no=00:mi=00:mh=00:ln=01;36:or=01;31:di=01;34:ow=04;01;34:st=34:tw=04;34:pi=01;33:so=01;33:do=01;33:bd=01;33:cd=01;33:su=01;34:sg=01;35:ca=01;35:ex=01;32:'
