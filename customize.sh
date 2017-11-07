# Install vim & tmux
sudo apt-get install vim -y
sudo apt-get install tmux -y
sudo apt-get install redshift -y

# putting in configurations
if [ ! -d "~/Documents/MyConfigs" ]; then
  git clone https://github.com/laveesingh/MyConfigs.git ~/Documents/MyConfigs
fi
ln -s ~/Documents/MyConfigs/.vimrc ~
ln -s ~/Documents/MyConfigs/.tmux.conf ~
ln -s ~/Documents/MyConfigs/.bashrc ~
ln -s ~/Documents/MyConfigs/.bash_aliases ~

# Install pathogen vim package manager
#echo "installing pathogen..."
mkdir -p ~/.vim/autoload ~/.vim/bundle && \
  curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim


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

# install YouCompleteMe for vim
cd ~/.vim/bundle && git clone https://github.com/Valloric/YouCompleteMe.git
cd YouCompleteMe
git submodule update --init --recursive
./install.py


# install tmux-resurrect
git clone https://github.com/tmux-plugins/tmux-resurrect ~/.tmux/tmux-resurrect
tmux source-file ~/.tmux.conf
