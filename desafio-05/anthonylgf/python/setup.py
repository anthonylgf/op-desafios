from setuptools import setup, Extension
from Cython.Build import cythonize

external_modules = cythonize([Extension("processar_funcionarios", ["processar_funcionarios.pyx"])])

setup(
    name='desafio05-python-anthonylgf',
    version='2.0',
    ext_modules=external_modules,
    zip_safe=False
)
