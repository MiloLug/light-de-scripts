# perconf - percentage configuration utility
# See LICENSE file for copyright and license details.

include config.mk

install:
	mkdir -p ${DESTDIR}${PREFIX}/de-scripts
	rm -rf ${DESTDIR}${PREFIX}/de-scripts/*
	cp -r src/* ${DESTDIR}${PREFIX}/de-scripts

uninstall:
	rm -f ${DESTDIR}${PREFIX}/de-scripts

.PHONY: install uninstall
