from code import InteractiveConsole
from tempfile import mkstemp
import dis
import os
import sys

"""
    From https://github.com/sontek/dotfiles/blob/master/_pythonrc.py
"""


#
# use readline w/ tab complete
#
try:
    import readline
except ImportError:
    print("Module readline not available.")
else:
    import rlcompleter
    readline.parse_and_bind("tab: complete")
#
# make dis a builtin
#
try:
    import __builtin__
    __builtin__.dis = dis
except ImportError:
    __builtins__.dis = dis
finally:
    del dis

#
# pretty print
#
def my_displayhook(value):
    if value is not None:
        import pprint
        try:
            import __builtin__
            __builtin__._ = value
        except ImportError:
            __builtins__._ = value
        pprint.pprint(value)
sys.displayhook = my_displayhook

#
# use vim as external editor
#
EDITOR = os.environ.get('EDITOR', 'vim')
EDIT_CMD = '\e'
class EditableBufferInteractiveConsole(InteractiveConsole, object):
    def __init__(self, *args, **kwargs):
        self.last_buffer = [] # This holds the last executed statement
        self._super = super(EditableBufferInteractiveConsole, self)
        self._super.__init__(*args, **kwargs)

    def runsource(self, source, *args):
        if source.strip():
            self.last_buffer = [source.encode('latin-1')]
        return self._super.runsource(source, *args)

    def raw_input(self, *args):
        line = self._super.raw_input(*args)
        if line.strip() == EDIT_CMD:
            fd, tmpfl = mkstemp('.py')
            os.write(fd, b'\n'.join(self.last_buffer))
            os.close(fd)
            os.system('%s %s' % (EDITOR, tmpfl))
            line = open(tmpfl).read()
            os.unlink(tmpfl)
            del tmpfl
            lines = line.split('\n')
            for _line in lines:
                self.push(_line)
            self.last_buffer = [line.encode('latin-1')]
            line = lines[-1]
        return line

c = EditableBufferInteractiveConsole(locals=locals())
c.interact(banner='')

# Exit the Python shell on exiting the InteractiveConsole
sys.exit()

