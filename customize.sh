# Install vim & tmux
sudo apt-get install vim -y
sudo apt-get install tmux -y

# putting in configurations
if [ ! -d "~/Documents/MyConfigs" ]; then
  git clone https://github.com/laveesingh/MyConfigs.git ~/Documents/MyConfigs
fi
ln -s ~/Documents/MyConfigs/.vimrc ~
ln -s ~/Documents/MyConfigs/.tmux.conf ~
ln -s ~/Documents/MyConfigs/.bashrc ~
ln -s ~/Documents/MyConfigs/.bash_aliases ~

# Install pathogen vim package manager
echo "installing pathogen..."
mkdir -p ~/.vim/autoload ~/.vim/bundle && \
  curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim


# Install sublime colorschmes for vim
echo "installing molokai colorscheme for vim"
cd ~/.vim
git clone https://github.com/tomasr/molokai.git
git clone https://github.com/sickill/vim-monokai.git
mkdir -p colors
mv molokai/colors/molokai.vim colors/
mv vim-monokai/colors/monokai.vim colors/
rm -rf molokai/
rm -rf vim-monokai/


# Install vim plugins
cd ~/.vim/bundle && git clone https://github.com/scrooloose/nerdcommenter.git






# Install vim plugins
cd ~/.vim/bundle/ && git clone https://github.com/mxw/vim-jsx.git
cd ~/.vim/bundle && git clone https://github.com/pangloss/vim-javascript
cd ~/.vim/bundle && git clone https://github.com/raimondi/delimitmate
cd ~/.vim/bundle && git clone https://github.com/othree/html5.vim

# install xbuild for vim-ycm
sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 3FA7E0328081BFF6A14DA29AA6A19B38D3D831EF
echo "deb http://download.mono-project.com/repo/debian wheezy main" | sudo tee /etc/apt/sources.list.d/mono-xamarin.list
sudo apt-get update
sudo apt-get install mono-complete
sudo npm install -g xbuild
sudo apt-get install mono-xbuild

# vim-syntastic extensions
sudo npm install -g eslint babel-eslint eslint-plugin-react syntastic-react jshint react-tools

