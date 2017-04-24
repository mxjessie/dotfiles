from powerline.bindings.ipython.since_5 import PowerlinePrompts
c = get_config()

c.InteractiveShell.autoindent = True
c.InteractiveShell.editor = 'vim'
c.InteractiveShellApp.extensions = ['autoreload']
c.InteractiveShellApp.exec_lines = ['%autoreload 2']

c.TerminalInteractiveShell.simple_prompt = False
c.TerminalInteractiveShell.prompts_class = PowerlinePrompts
