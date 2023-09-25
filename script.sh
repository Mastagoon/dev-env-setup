#!/bin/sh
apt-get update
apt-get install tmux git curl wget make -y
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
	echo "Installing neovim"
	wget https://github.com/neovim/neovim/releases/download/nightly/nvim.appimage -O /usr/bin/nvim
	echo "Installing nvim-plug"
	sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
				 https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
fi

git clone https://github.com/mastagoon/dotfiles ~/.dotfiles
ln -s ~/.dotfiles/.zshrc ~/.zshrc
ln -s ~/.dotfiles/.tmux.conf ~/.tmux.conf
ln -s ~/.dotfiles/.config/nvim ~/.config/nvim
ln -s ~/.dotfiles/.config/i3 ~/.config/i3
