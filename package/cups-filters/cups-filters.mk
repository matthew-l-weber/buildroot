#############################################################
#
# cups-filters
#
#############################################################
CUPS_FILTERS_VERSION = 1.0.67
CUPS_FILTERS_SITE = http://openprinting.org/download/cups-filters/
CUPS_FILTERS_LICENSE = GPLv2+
CUPS_FILTERS_LICENSE_FILES = COPYING

CUPS_FILTERS_DEPENDENCIES = cups libglib2 ijs lcms2 poppler qpdf

CUPS_FILTERS_CONF_OPTS = --disable-avahi \
                        --disable-imagefilters \
                        --with-cups-config=$(STAGING_DIR)/usr/bin/cups-config \
                        --without-png \
                        --with-sysroot=$(STAGING_DIR)

ifeq ($(BR2_PACKAGE_CUPS_FILTERS_PDFTOPS),y)
	CUPS_FILTERS_CONF_OPTS += --with-pdftops=pdftops
endif

ifeq ($(BR2_PREFER_STATIC_LIB),y)
	CUPS_FILTERS_CONF_OPTS += --disable-shared \
				  --enable-static
else
	CUPS_FILTERS_CONF_OPTS += --enable-shared
endif

ifeq ($(BR2_PACKAGE_JPEG),y)
	CUPS_FILTERS_CONF_OPTS += --with-jpeg
	CUPS_FILTERS_DEPENDENCIES += jpeg
else
	CUPS_FILTERS_CONF_OPTS += --without-jpeg
endif

ifeq ($(BR2_PACKAGE_LIBPNG),y)
	CUPS_FILTERS_CONF_OPTS += --with-png
	CUPS_FILTERS_DEPENDENCIES += libpng
else
	CUPS_FILTERS_CONF_OPTS += --without-png
endif

ifeq ($(BR2_PACKAGE_TIFF),y)
	CUPS_FILTERS_CONF_OPTS += --with-tiff
	CUPS_FILTERS_DEPENDENCIES += tiff
else
	CUPS_FILTERS_CONF_OPTS += --without-tiff
endif

ifeq ($(BR2_PACKAGE_DBUS),y)
	CUPS_FILTERS_CONF_OPTS += --enable-dbus
	CUPS_FILTERS_DEPENDENCIES += dbus
else
	CUPS_FILTERS_CONF_OPTS += --disable-dbus
endif

ifeq ($(BR2_PACKAGE_CUPS_FILTERS_AVAHI),y)
	CUPS_FILTERS_DEPENDENCIES += avahi
	CUPS_FILTERS_CONF_OPTS += --enable-avahi
else
	CUPS_FILTERS_CONF_OPTS += --disable-avahi
endif

$(eval $(autotools-package))
