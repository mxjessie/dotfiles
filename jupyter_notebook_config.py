import os

c.NotebookApp.enable_mathjax = True
c.NotebookApp.notebook_dir = '{0}/notebooks'.format(os.path.expanduser('~'))
c.NotebookApp.open_browser = False
