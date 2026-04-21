# ─── Python interactive startup ───────────────────────────────────────────────
# Loaded automatically via $PYTHONSTARTUP (set in .zshrc)
import sys, os

# Enable tab completion in the REPL
try:
    import readline
    import rlcompleter
    readline.parse_and_bind("tab: complete")
    history = os.path.expanduser("~/.local/share/python/history")
    os.makedirs(os.path.dirname(history), exist_ok=True)
    try:
        readline.read_history_file(history)
    except FileNotFoundError:
        pass
    import atexit
    atexit.register(readline.write_history_file, history)
except ImportError:
    pass

# Useful imports available immediately in REPL
try:
    from pathlib import Path
    from datetime import datetime, date
    import json, re, math, random, itertools, functools
except ImportError:
    pass

# Pretty-print by default
try:
    import pprint
    def pp(obj, **kw): pprint.pprint(obj, **kw)
except ImportError:
    pass

print(f"\033[34mPython {sys.version.split()[0]} — Xeno OS\033[0m  "
      f"\033[90mType pp(obj) for pretty-print\033[0m")
