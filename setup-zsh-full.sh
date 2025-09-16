#!/usr/bin/env bash
set -e

echo "🚀 Starting full installation of Zsh + Powerlevel10k + plugins + tools..."

command_exists() {
  command -v "$1" >/dev/null 2>&1
}

if [ ! -d "$HOME/.oh-my-zsh" ]; then
  echo "Installing Oh My Zsh..."
  bash -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
else
  echo "Oh My Zsh already installed."
fi

ZSH="$HOME/.oh-my-zsh"

if [ ! -d "$ZSH/custom/themes/powerlevel10k" ]; then
  echo "Installing Powerlevel10k..."
  git clone --depth=1 https://github.com/romkatv/powerlevel10k.git $ZSH/custom/themes/powerlevel10k
else
  echo "Powerlevel10k already installed."
fi

# 3️⃣ Plugins
PLUGINS_DIR="$ZSH/custom/plugins"

# zsh-autosuggestions
if [ ! -d "$PLUGINS_DIR/zsh-autosuggestions" ]; then
  echo "Installing zsh-autosuggestions..."
  git clone https://github.com/zsh-users/zsh-autosuggestions $PLUGINS_DIR/zsh-autosuggestions
fi

# zsh-syntax-highlighting
if [ ! -d "$PLUGINS_DIR/zsh-syntax-highlighting" ]; then
  echo "Installing zsh-syntax-highlighting..."
  git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $PLUGINS_DIR/zsh-syntax-highlighting
fi

# fzf
if ! command_exists fzf; then
  echo "Installing fzf..."
  brew install fzf
  $(brew --prefix)/opt/fzf/install --all
fi

# zoxide
if ! command_exists zoxide; then
  echo "Installing zoxide..."
  brew install zoxide
fi

# nvm (Node.js)
if ! command_exists nvm; then
  echo "Installing nvm..."
  brew install nvm
  mkdir -p ~/.nvm
fi

# pyenv (Python)
if ! command_exists pyenv; then
  echo "Installing pyenv..."
  brew install pyenv
fi

# Go
if ! command_exists go; then
  echo "Installing Go..."
  brew install go
fi

# Protoc
if ! command_exists protoc; then
  echo "Installing Protoc..."
  brew install protobuf
fi

if [ -f "$HOME/.zshrc" ]; then
  echo "Backing up current .zshrc..."
  cp ~/.zshrc ~/.zshrc.backup
fi

echo "Creating optimized .zshrc..."
cat > ~/.zshrc << 'EOF'
# Enable Powerlevel10k instant prompt (topo)
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="powerlevel10k/powerlevel10k"

plugins=(
  git
  zsh-autosuggestions
  fzf
  zsh-syntax-highlighting
)

source $ZSH/oh-my-zsh.sh

export ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=20
export ZSH_AUTOSUGGEST_USE_ASYNC=1

# NVM (Node.js)
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

# Pyenv (Python)
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init --path)"

# Go
export PATH=$PATH:$(go env GOPATH)/bin

# Protoc
export PATH=$PATH:/opt/homebrew/bin/protoc

# Zoxide
eval "$(zoxide init zsh)"
alias cd=z
alias cdi=zi

# fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Powerlevel10k config
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
EOF

echo "Reloading .zshrc..."
source ~/.zshrc

# Run Powerlevel10k configure
echo "Opening Powerlevel10k configure wizard..."
p10k configure

echo "✅ Everything ready! Your terminal is configured with Zsh + Powerlevel10k + plugins + tools."
