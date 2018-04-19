#! /usr/bin/python3

from io_utils import Log
from menu import VIM_PACKAGES


class Vim:

    def __init__(self, packages, nerd_level=9):
        # nerd level determines what to which extent we're going to install packages
        self.packages = packages

    def set_config_file(self):
        pass

    def customize_packages(self):
        # take user opinion on editing the list
        pass

    def install_packages_through_vim_plug(self):
        pass

    def install_packages_through_pathogen(self):
        pass


class Apt:

    def __init__(self, software_list, nerd_level=9):
        # nerd level determines what to which extent we're going to install softwares
        self.software_list = software_list

    def customize_software_list(self):
        # take user opinion on editing the list
        pass

    def install_softwares_list(self):
        pass


class Python:

    def __init__(self, packages, nerd_level=9):
        self.packages = packages

    def customize_packages(self):
        pass

    def install_packages(self):
        pass


class Tmux:

    def __init__(self, packages):
        self.packages = packages

    def customize_packages(self):
        pass

    def install_packages(self):
        pass


if __name__ == '__main__':
    log = Log()
