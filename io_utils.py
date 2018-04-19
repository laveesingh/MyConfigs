

class Log:

    def __init__(self, *args, **kwargs):
        pass

    def alert(self, msg):
        print('\033[31m' + msg + '\033[0m')

    def warn(self, msg):
        print('\033[33m' + msg + '\033[0m')

    def info(self, msg):
        print('\033[34m' + msg + '\033[0m')

    def success(self, msg):
        print('\033[36m' + msg + '\033[0m')

    def focus(self, msg):
        print('\033[40m' + msg + '\033[0m')

