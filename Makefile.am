AUTOMAKE_OPTIONS = foreign
ACLOCAL_AMFLAGS = -I m4
SUBDIRS = src
EXTRA_DIST = autogen.sh README.md LICENSE Changes

pkgconfigdir = $(libdir)/pkgconfig
pkgconfig_DATA = src/dontpanic.pc

test:
	prove -v t
