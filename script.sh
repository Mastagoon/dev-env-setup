#!/bin/sh
apt-get update
apt-get install tmux git curl make -y
# check if i3-cinnamon exists
if ! command -v i3-cinnamon; then
		# install i3-cinnamon
		echo "Installing i3-cinnamon..."
		git clone https://github.com/jthomaschewski/i3-cinnamon
		cd i3-cinnamon
		make install
fi

echo "Checking if TPM is installed..."
TPM_DIR = ~/.tmux/plugins/tpm
if ! [ -d "$TPM_DIR" ]; then
	echo "Installing TPM..."
	git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
fi

if ! command --version zsh; then
	echo "Installing zsh..."
	apt-get install zsh -y
	echo "Changing default shell to zsh..."
	chsh -s $(which zsh)
	echo "Installing oh-my-zsh..."
	sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
	echo "Installing oh-my-zsh plugins"
	git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
	git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
	echo "Installing powerline fonts"
	apt-get	install fonts-powerline
fi

if ! command -v nvim; then
	echo "Installinv neovim"
	curl -sL https://github.com/neovim/neovim/releases/download/nightly/nvim.appimage
fi
