c = get_config()

c.InteractiveShell.autoindent = True
c.InteractiveShell.editor = 'vim'
c.InteractiveShellApp.extensions = ['autoreload']
c.InteractiveShellApp.exec_lines = ['%autoreload 2']
