from powerline.bindings.ipython.since_5 import PowerlinePrompts
C = get_config()

C.InteractiveShell.autoindent = True
C.InteractiveShell.editor = 'vim'
C.InteractiveShellApp.extensions = ['autoreload']
C.InteractiveShellApp.exec_lines = ['%autoreload 2']

C.TerminalInteractiveShell.confirm_exit = False
C.TerminalInteractiveShell.simple_prompt = False
C.TerminalInteractiveShell.prompts_class = PowerlinePrompts
