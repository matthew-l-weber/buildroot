################################################################################
#
# python-pycups
#
################################################################################

PYTHON_PYCUPS_VERSION = 1.9.73
PYTHON_PYCUPS_SOURCE = pycups-$(PYTHON_PYCUPS_VERSION).tar.bz2
PYTHON_PYCUPS_SITE = https://pypi.python.org/packages/source/p/pycups
PYTHON_PYCUPS_LICENSE = GPLc2+
PYTHON_PYCUPS_LICENSE_FILES = LICENSE
PYTHON_PYCUPS_SETUP_TYPE = distutils
PYTHON_PYCUPS_DEPENENCIES = cups

$(eval $(python-package))
