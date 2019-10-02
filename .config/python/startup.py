import atexit
import os
import readline

HOME = os.path.expanduser("~")
XDG_DATA_HOME = os.environ.get("XDG_DATA_HOME", os.path.join(HOME, ".local", "share"))
PYTHON_DATA_HOME = os.path.join(XDG_DATA_HOME, "python")
HISTFILE = os.path.join(PYTHON_DATA_HOME, "history")

if os.path.isfile(os.path.join(HOME, ".python_history")):
    print("Migrating old .python_history")
    if not os.path.exists(PYTHON_DATA_HOME):
        os.makedirs(PYTHON_DATA_HOME)
    os.rename(os.path.join(HOME, ".python_history"), HISTFILE)
try:
    readline.read_history_file(HISTFILE)
    h_len = readline.get_current_history_length()
except FileNotFoundError:
    if not os.path.exists(PYTHON_DATA_HOME):
        os.makedirs(PYTHON_DATA_HOME)
    open(HISTFILE, "wb").close()
    h_len = 0


def save(prev_h_len, histfile):
    import readline
    new_h_len = readline.get_current_history_length()
    readline.set_history_length(10000)
    readline.append_history_file(new_h_len - prev_h_len, histfile)


atexit.register(save, h_len, HISTFILE)
del (atexit, os, readline, h_len, save, HOME, XDG_DATA_HOME, PYTHON_DATA_HOME, HISTFILE)
