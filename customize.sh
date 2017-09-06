
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
