# Setup Zsh Full 🚀

[![Shell](https://img.shields.io/badge/Shell-Zsh-blue)](https://www.zsh.org/)  
[![License](https://img.shields.io/badge/License-MIT-green)](LICENSE)  
[![Oh My Zsh](https://img.shields.io/badge/Oh_My_Zsh-Installed-orange)](https://ohmyz.sh/)

`setup-zsh-full.sh` is an automated script to install and configure a **complete Zsh development environment** on Linux, including:

- [Oh My Zsh](https://ohmyz.sh/)  
- [Powerlevel10k](https://github.com/romkatv/powerlevel10k)  
- Useful plugins: `git`, `zsh-autosuggestions`, `fzf`, `zoxide`  
- [NVM](https://github.com/nvm-sh/nvm) for Node.js version management  
- Optimized `.zshrc` with aliases and shortcuts  

This script provides a ready-to-use setup with a **beautiful prompt, auto-suggestions, git aliases, and productivity tools**.

---

## ⚙️ Prerequisites

- Ubuntu or compatible Linux distribution  
- Zsh installed (`sudo apt install zsh`)  
- Git installed (`sudo apt install git`)  
- Curl or wget to download the script  

> ⚠️ Do **not** run with `sh setup-zsh-full.sh`. Use `zsh` or make the script executable.

---

## 💻 One-Liner Installation

For a **quick setup**, copy and paste the following in your terminal:

```bash
git clone <REPO_URL> && cd <SCRIPT_FOLDER> && chmod +x setup-zsh-full.sh && zsh setup-zsh-full.sh
