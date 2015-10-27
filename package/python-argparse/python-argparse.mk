################################################################################
#
# python-cloudprint
#
################################################################################

PYTHON_ARGPARSE_VERSION = 1.3.0
PYTHON_ARGPARSE_SOURCE = argparse-$(PYTHON_ARGPARSE_VERSION).tar.gz
PYTHON_ARGPARSE_SITE = https://pypi.python.org/packages/source/a/argparse
PYTHON_ARGPARSE_LICENSE = GPLv3
PYTHON_ARGPARSE_LICENSE_FILES = COPYING
PYTHON_ARGPARSE_SETUP_TYPE = setuptools
PYTHON_ARGPARSE_DEPENDENCIES = python

$(eval $(python-package))
