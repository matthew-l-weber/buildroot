################################################################################
#
# python-cloudprint
#
################################################################################

PYTHON_CLOUDPRINT_VERSION = 0a233bb358e2b16f0e6a787115b33b45b7e1102c
PYTHON_CLOUDPRINT_SITE = https://github.com/armooo/cloudprint.git
PYTHON_CLOUDPRINT_SITE_METHOD = git
PYTHON_CLOUDPRINT_LICENSE = GPLv3+
PYTHON_CLOUDPRINT_LICENSE_FILES = COPYING
PYTHON_CLOUDPRINT_SETUP_TYPE = setuptools
PYTHON_CLOUDPRINT_DEPENDENCIES = cups python-pycups python-daemon python

$(eval $(python-package))
