# inicia o ambiente virtual do python com o terminal
source $HOME/.venv/bin/activate

# executa neofetch
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

# compostamento do auto update
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
alias cpd="sudo openvpn --config ~/Documents/vpn-cpd-v1.1.ovpn"
alias pst="ls -lah | grep ^drw"
alias arq="ls -lah | grep ^-rw"
alias pfless="fzf --preview='less {}' --bind up:preview-page-up,down:preview-page-down"
alias pfbat="fzf --preview 'bat --style=numbers --color=always --line-range :500 {}'"
alias vim="vim -S ~/.config/vim/vimrc"
alias odia="vim ~/Documents/dia.txt"
alias tempo="/usr/bin/time -p"
alias rm='echo "This is not the command you are looking for."; false'

# controle dos leds da gpu
alias gpu_100="nvidia-settings --assign GPULogoBrightness=100 >> /dev/null"
alias gpu_0="nvidia-settings --assign GPULogoBrightness=0 >> /dev/null"

# alias do pacman
alias orfaos="pacman -Qtd"
alias remove_orfaos="sudo pacman -Runs $(pacman -Qdt)"
alias instalados="pacman -Qe"
alias update="sudo pacman -Suvy && yay -Suvy"
alias limpa_tudo="sudo pacman -Scc && yay -Scc"
# alias cdf="cd './$(find -type d | fzf)'"

# PlayStation
alias gaming="sudo ./Apps/chiaki.appimage"

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# atalhos
bindkey '^k' history-search-backward
bindkey '^j' history-search-forward

# integrações do shell
eval "$(zoxide init --cmd cd zsh)"
eval "$(fzf --zsh)"

# cores para o fzf
export FZF_DEFAULT_OPTS='
  --color=bg+:#313244,bg:#1e1e2e,spinner:#f5e0dc,hl:#f38ba8
  --color=fg:#cdd6f4,header:#f38ba8,info:#cba6f7,pointer:#f5e0dc
  --color=marker:#f5e0dc,fg+:#cdd6f4,prompt:#cba6f7,hl+:#f38ba8
'
  #--color=dark
  #--color=fg:-1,bg:-1,hl:#c678dd,fg+:#ffffff,bg+:#4b5263,hl+:#d858fe
  #--color=info:#98c379,prompt:#61afef,pointer:#be5046,marker:#e5c07b,spinner:#61afef,header:#61afef

