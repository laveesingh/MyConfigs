#! /usr/bin/python3

import argparse
import json
import os
import shlex
import subprocess


alert = lambda msg: print('\033[31m' + msg + '\033[0m')
warn = lambda msg: print('\033[33m' + msg + '\033[0m')
info = lambda msg: print('\033[34m' + msg + '\033[0m')
success = lambda msg: print('\033[36m' + msg + '\033[0m')
focus = lambda msg: print('\033[40m' + msg + '\033[0m')


def parse_arguments():
    parser = argparse.ArgumentParser()
    parser.add_argument('--ssh', type=bool, default=False, help='if given, git uses ssh for connection otherwise https')
    parser.add_argument('--apt', nargs='+', default='', help='apt packages list')
    parser.add_argument('--vim', nargs='+', default='', help='vim packages list')
    parser.add_argument('--python', nargs='+', default='', help='python packages list')
    return parser.parse_args()


def execute(cmd_str):
    args = shlex.split(cmd_str)
    proc = subprocess.Popen(args, universal_newlines=True)
    proc.communicate()


def install_apt_packages(packages_list):
    '''
    A package in packages_list looks something like this: 'bpython'
    '''
    for package in packages_list:
        proc = subprocess.Popen(['which', package])
        try:
            proc.wait(timeout=1)
            exitcode = proc.poll()
        except:
            exitcode = 1
        if exitcode:
            cmd_str = 'sudo apt install -y %s' % package
            info('installing apt package [%s]...' % package)
            execute(cmd_str)
            success('installed package [%s]' % package)
        else:
            warn('package [%s] is already installed' % package)


def install_vim_packages(packages_list):
    '''
    A package in packages_list looks something like: {
        'user': 'tpope',
        'name': 'fugitive'
    }
    '''
    cwd = os.getcwd()
    os.chdir('/home/lavee/.vim/bundle/')  # do something with this static username
    for plugin in packages_list:
        if os.path.isfile(plugin['name']) or os.path.isdir(plugin['name']):
            warn('vim package [%s] is already installed' % plugin['name'])
            continue
        try:
            remote_path = 'git@github.com:%s/%s.git' if args.ssh else 'https://github.com/%s/%s.git'
            remote_path = remote_path % (plugin['user'], plugin['name'])
            cmd_str = 'git clone %s' % remote_path
            info('installing vim plugin [%s]' % plugin['name'])
            execute(cmd_str)
            success('installed vim package [%s]' % plugin['name'])
        except:
            alert('vim package [%s] could not be installed' % plugin)
    os.chdir(cwd)


def install_python_packages(packages_list):
    '''
    A package in packages_list looks something like: 'bs4'
    '''
    for package in packages_list:
        try:
            cmd_str2 = 'sudo pip install %s' % package
            cmd_str3 = 'sudo pip3 install %s' % package
            info('install [%s] package for python2 and python3' % package)
            execute(cmd_str2)
            execute(cmd_str3)
            success('installed python package [%s]' % package)
        except:
            alert('python package [%s] could not be installed' % package)


if __name__ == '__main__':
    apt_packages_list = []
    vim_packages_list = []
    python_packages_list = []
    args = parse_arguments()
    if args.apt or args.vim or args.python:
        apt_packages_list = args.apt if args.apt else []
        vim_packages_list = args.vim if args.vim else []
        vim_packages_list = [{ 'user': s.split('/')[0], 'name': s.split('/')[1] } for s in vim_packages_list ]
        python_packages_list = args.python if args.python else []
    else:
        with open('dependencies.json') as f:
            json_data = json.loads(f.read())
            apt_packages_list = json_data['apt']
            vim_packages_list = json_data['vim']
            python_packages_list = json_data['python']
    install_apt_packages(apt_packages_list)
    install_vim_packages(vim_packages_list)
    install_python_packages(python_packages_list)
    if args.apt or args.vim or args.python:
        with open('dependencies.json') as f:
            json_data = json.loads(f.read())
            apt_packages_list += json_data['apt']
            vim_packages_list += json_data['vim']
            python_packages_list += json_data['python']
        f = open('dependencies.json', 'w+')
        json_dict = {
            'python': python_packages_list,
            'vim': vim_packages_list,
            'apt': apt_packages_list
        }
        f.write(json.dumps(json_dict, sort_keys=True, indent=4))
