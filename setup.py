import os
from distutils.core import setup

def read(fname):
    return open(os.path.join(os.path.dirname(__file__), fname)).read()

setup(
    name = 'real_world_machine_learning',
    version = read('VERSION'),
    author = 'Eric Bailey',
    author_email = 'eric@ericb.me',
    description = 'Real-World Machine Learning',

    license = 'BSD',
    url = 'https://github.com/yurrriq/real_world_machine_learning',
    packages = ['real_world_machine_learning'],
)
