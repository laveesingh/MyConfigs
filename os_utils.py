import shlex
import subprocess
import sys


class Worker:

    def __init__(self):
        pass

    def make_link(self, source, target, **kwargs):
        cmd_str = '{sudo} ln {soft} {source} {target}'.format(
            sudo='sudo' if kwargs.get('sudo') else '',
            soft='-s' if kwargs.get('soft') else '',
            source=source,
            target=target
        )
        self.execute_cmd(cmd_str)

    def execute_cmd(self, cmd_str, **kwargs):
        cmd_list = shlex.split(cmd_str)
        if kwargs.get('capture_output'):
            process = subprocess.Popen(cmd_list, stdout=subprocess.PIPE)
        else:
            process = subprocess.Popen(cmd_list, stdout=sys.stdout)
        if kwargs.get('wait'):
            process.wait()
