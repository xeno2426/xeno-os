# ╔══════════════════════════════════════════════════════════════════╗
# ║                 Xeno OS — .zshrc                                 ║
# ║  Plugin manager: zinit | Prompt: Starship                        ║
# ╚══════════════════════════════════════════════════════════════════╝

# ─── XDG Base Dirs ───────────────────────────────────────────────────────────
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_STATE_HOME="$HOME/.local/state"

# ─── History ─────────────────────────────────────────────────────────────────
HISTFILE="$XDG_STATE_HOME/zsh/history"
HISTSIZE=50000
SAVEHIST=50000
mkdir -p "$(dirname "$HISTFILE")"

setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_VERIFY
setopt SHARE_HISTORY
setopt EXTENDED_HISTORY

# ─── Options ─────────────────────────────────────────────────────────────────
setopt AUTO_CD
setopt AUTO_PUSHD
setopt PUSHD_IGNORE_DUPS
setopt PUSHD_SILENT
setopt CORRECT
setopt COMPLETE_IN_WORD
setopt ALWAYS_TO_END
setopt GLOB_DOTS
setopt EXTENDED_GLOB

# ─── Completion ──────────────────────────────────────────────────────────────
autoload -Uz compinit
compinit -d "$XDG_CACHE_HOME/zsh/zcompdump"

zstyle ':completion:*'          menu select
zstyle ':completion:*'          matcher-list 'm:{a-zA-Z}={A-Za-z}'
zstyle ':completion:*'          list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*:warnings' format ' %F{red}No matches%f'
zstyle ':completion:*:*:*:*:*'  menu yes select
zstyle ':completion::complete:*' gain-privileges 1

# ─── zinit Plugin Manager ────────────────────────────────────────────────────
ZINIT_HOME="${XDG_DATA_HOME}/zinit/zinit.git"

if [[ ! -d "$ZINIT_HOME" ]]; then
    print -P "%F{cyan}Installing zinit...%f"
    command mkdir -p "$(dirname $ZINIT_HOME)"
    command git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

source "${ZINIT_HOME}/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

# ─── Plugins ─────────────────────────────────────────────────────────────────

# Syntax highlighting (must be last)
zinit light zsh-users/zsh-syntax-highlighting

# Autosuggestions
zinit light zsh-users/zsh-autosuggestions

# History substring search (up/down arrows)
zinit light zsh-users/zsh-history-substring-search
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

# Extra completions
zinit light zsh-users/zsh-completions

# fzf tab completion
zinit light Aloxaf/fzf-tab

# z — jump to frecent directories
zinit light agkozak/zsh-z

# Autosuggestions config
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#585b70"
ZSH_AUTOSUGGEST_STRATEGY=(history completion)
ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=20

# ─── fzf ─────────────────────────────────────────────────────────────────────
if command -v fzf &>/dev/null; then
    export FZF_DEFAULT_OPTS="
        --color=bg+:#313244,bg:#1e1e2e,spinner:#f5e0dc,hl:#f38ba8
        --color=fg:#cdd6f4,header:#f38ba8,info:#cba6f7,pointer:#f5e0dc
        --color=marker:#b4befe,fg+:#cdd6f4,prompt:#cba6f7,hl+:#f38ba8
        --color=selected-bg:#45475a
        --height=40% --layout=reverse --border=rounded
        --prompt='  ' --pointer=' ' --marker=' '
    "
    export FZF_DEFAULT_COMMAND="fd --type f --hidden --follow --exclude .git"
    export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
    export FZF_ALT_C_COMMAND="fd --type d --hidden --follow --exclude .git"

    source <(fzf --zsh) 2>/dev/null || true
fi

# fzf-tab config
zstyle ':fzf-tab:complete:cd:*'     fzf-preview 'eza --tree --color=always $realpath 2>/dev/null | head -50'
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'eza --tree --color=always $realpath 2>/dev/null | head -50'

# ─── Environment Variables ────────────────────────────────────────────────────
export EDITOR="nvim"
export VISUAL="nvim"
export PAGER="less"
export LESS="-R --mouse"
export MANPAGER="sh -c 'col -bx | bat -l man -p'"
export LANG="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"

# Path additions
export PATH="$HOME/.local/bin:$HOME/.cargo/bin:$HOME/.npm-global/bin:$PATH"

# Python
export PYTHONSTARTUP="$HOME/.config/python/startup.py"
export VIRTUAL_ENV_DISABLE_PROMPT=1

# ─── Aliases — Navigation ────────────────────────────────────────────────────
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias ~='cd ~'
alias -- -='cd -'

# ─── Aliases — File Listing (eza) ────────────────────────────────────────────
if command -v eza &>/dev/null; then
    alias ls='eza --color=always --group-directories-first --icons'
    alias ll='eza -lah --color=always --group-directories-first --icons --git'
    alias la='eza -a --color=always --group-directories-first --icons'
    alias lt='eza --tree --level=2 --color=always --icons'
    alias l.='eza -a | grep -E "^\."'
else
    alias ls='ls --color=auto'
    alias ll='ls -lah --color=auto'
    alias la='ls -A --color=auto'
fi

# ─── Aliases — File Operations ────────────────────────────────────────────────
alias cp='cp -iv'
alias mv='mv -iv'
alias rm='rm -iv'
alias mkdir='mkdir -pv'
alias df='df -h'
alias free='free -mh'
alias du='du -sh'

# ─── Aliases — Text / Search ──────────────────────────────────────────────────
if command -v bat &>/dev/null; then
    alias cat='bat --style=plain'
    alias catt='bat'
fi
if command -v fd &>/dev/null; then
    alias find='fd'
fi
alias grep='grep --color=auto'
alias rg='rg --color=auto'

# ─── Aliases — Editor ────────────────────────────────────────────────────────
alias vim='nvim'
alias vi='nvim'
alias v='nvim'
alias nv='nvim'

# ─── Aliases — System ────────────────────────────────────────────────────────
alias top='btop'
alias htop='btop'
alias ps='ps auxf'
alias psa='ps aux | grep'
alias svc='systemctl'
alias svcu='systemctl --user'
alias jctl='journalctl -xe'

# ─── Aliases — Pacman / AUR (#14) ────────────────────────────────────────────
alias aur='yay'
alias pac='sudo pacman'
alias update='sudo pacman -Syu && yay -Sua --noconfirm'
alias install='yay -S'
alias remove='sudo pacman -Rns'
alias search='yay -Ss'
alias pkginfo='yay -Qi'
alias pkglist='pacman -Q'
alias orphans='pacman -Qdt'
alias cleanup='sudo pacman -Rns $(pacman -Qtdq) 2>/dev/null || echo "No orphans"'
alias mirrors='sudo reflector --latest 20 --protocol https --sort rate --save /etc/pacman.d/mirrorlist'

# ─── Aliases — Git ────────────────────────────────────────────────────────────
alias g='git'
alias gs='git status'
alias ga='git add'
alias gc='git commit'
alias gcm='git commit -m'
alias gp='git push'
alias gpl='git pull'
alias gl='git log --oneline --graph --decorate'
alias gd='git diff'
alias gb='git branch'
alias gco='git checkout'
alias gsw='git switch'

# ─── Aliases — Docker ────────────────────────────────────────────────────────
alias d='docker'
alias dc='docker compose'
alias dps='docker ps'
alias dpsa='docker ps -a'
alias di='docker images'
alias drm='docker rm'
alias drmi='docker rmi'

# ─── Aliases — Python / AI ───────────────────────────────────────────────────
alias py='python'
alias py3='python3'
alias ipy='ipython'
alias venv='python -m venv'
alias activate='source .venv/bin/activate || source venv/bin/activate'
alias ai='xeno-ai'

# ─── Aliases — Xeno OS ───────────────────────────────────────────────────────
alias lock='xeno-lock'
alias install-gui='xeno-installer'
alias firstrun='xeno-firstrun.sh'
alias wallpaper='xeno-wallpaper && nitrogen --restore'

# ─── Functions ────────────────────────────────────────────────────────────────

# Create dir and cd into it
mkcd() { mkdir -p "$1" && cd "$1"; }

# Extract any archive
extract() {
    if [[ -f "$1" ]]; then
        case "$1" in
            *.tar.bz2)  tar xjf "$1"    ;;
            *.tar.gz)   tar xzf "$1"    ;;
            *.tar.xz)   tar xJf "$1"    ;;
            *.bz2)      bunzip2 "$1"    ;;
            *.rar)      unrar x "$1"    ;;
            *.gz)       gunzip "$1"     ;;
            *.tar)      tar xf "$1"     ;;
            *.tbz2)     tar xjf "$1"    ;;
            *.tgz)      tar xzf "$1"    ;;
            *.zip)      unzip "$1"      ;;
            *.Z)        uncompress "$1" ;;
            *.7z)       7z x "$1"       ;;
            *)          echo "'$1' cannot be extracted" ;;
        esac
    else
        echo "'$1' is not a valid file"
    fi
}

# Quick HTTP server
serve() { python -m http.server "${1:-8000}"; }

# Quick Python calculator
calc() { python -c "print($*)"; }

# Git clone and cd
gclone() { git clone "$1" && cd "$(basename "$1" .git)"; }

# ─── Key Bindings ─────────────────────────────────────────────────────────────
bindkey -e                         # Emacs keybindings
bindkey '^[[1;5C' forward-word    # Ctrl+Right
bindkey '^[[1;5D' backward-word   # Ctrl+Left
bindkey '^H'      backward-kill-word
bindkey '^[[3~'   delete-char

# ─── Starship Prompt (#10) ───────────────────────────────────────────────────
if command -v starship &>/dev/null; then
    eval "$(starship init zsh)"
fi

# ─── First-run hook (#2) ─────────────────────────────────────────────────────
if [[ ! -f "$HOME/.config/xeno-setup-done" ]] && \
   command -v xeno-firstrun.sh &>/dev/null; then
    xeno-firstrun.sh
fi

# ─── fastfetch on new terminal ────────────────────────────────────────────────
if command -v fastfetch &>/dev/null && [[ -z "$XENO_NO_FETCH" ]]; then
    fastfetch
fi
