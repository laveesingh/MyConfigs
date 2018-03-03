# Install initial commands/tools
sudo apt -y install git vim tmux redshift curl wget xclip tree
sudo apt -y install python python-pip python3 python3-pip
sudo -H pip install -y youtube-dl ipython bpython

# Install nvm, node, npm
wget -qO- https://raw.githubusercontent.com/creationix/nvm/v0.33.6/install.sh | bash
bash
nvm install 8
nvm use 8

# putting in configurations
if [ ! -d "~/Documents/MyConfigs" ]; then
  git clone https://github.com/laveesingh/MyConfigs.git ~/Documents/MyConfigs
fi
if [ ! -f "~/.vimrc" ]; then
  ln -s ~/Documents/MyConfigs/.vimrc ~
fi
if [ ! -f "~/.tmux.conf" ]; then
  ln -s ~/Documents/MyConfigs/.tmux.conf ~
fi
if [ ! -f "~/.bashrc" ]; then
  ln -s ~/Documents/MyConfigs/.bashrc ~
fi
if [ ! -f "~/.bash_aliases" ]; then
  ln -s ~/Documents/MyConfigs/.bash_aliases ~
fi
if [ ! -f "~/.zshrc" ]; then
  ln -s ~/Documents/MyConfigs/.zshrc ~
fi
if [ ! -f "~/z.sh" ]; then
  ln -s ~/Documents/MyConfigs/z.sh ~
fi


# setup vim properly
if [ ! -d "~/.vim/bundle" ]; then
  mkdir -p ~/.vim/autoload ~/.vim/bundle && \
    curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim
fi

# Install sublime colorschmes for vim
#echo "installing molokai colorscheme for vim"
cd ~/.vim
git clone https://github.com/tomasr/molokai.git
git clone https://github.com/sickill/vim-monokai.git
mkdir -p colors
mv molokai/colors/molokai.vim colors/
mv vim-monokai/colors/monokai.vim colors/
rm -rf molokai/
rm -rf vim-monokai/
cd  # return back to home directory
# Install vim plugins
git clone https://github.com/scrooloose/nerdcommenter.git ~/.vim/bundle/nerdcommenter
git clone https://github.com/Raimondi/delimitMate.git ~/.vim/bundle/delimitMate
git clone https://github.com/terryma/vim-multiple-cursors.git  ~/.vim/bundle/vim-multiple-cursors
git clone https://github.com/mxw/vim-jsx.git ~/.vim/bundle/vim-jsx
git clone https://github.com/tpope/vim-surround.git ~/.vim/bundle/vim-surround
git clone https://github.com/SirVer/ultisnips ~/.vim/bundle/ultisnips
git clone https://github.com/pangloss/vim-javascript.git ~/.vim/bundle/vim-javascript
git clone https://github.com/pseewald/vim-anyfold.git ~/.vim/bundle/vim-any-fold
git clone https://github.com/prettier/vim-prettier.git ~/.vim/bundle/vim-prettier
git clone https://github.com/posva/vim-vue.git ~/.vivm/bundle/vim-vue
# install YouCompleteMe for vim
cd ~/.vim/bundle && git clone https://github.com/Valloric/YouCompleteMe.git
cd YouCompleteMe
git submodule update --init --recursive
./install.py


# install tmux-resurrect
git clone https://github.com/tmux-plugins/tmux-resurrect ~/.tmux/tmux-resurrect
tmux source-file ~/.tmux.conf


# vscode plugins list
