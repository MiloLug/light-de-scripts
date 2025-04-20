# perconf - percentage configuration utility
# See LICENSE file for copyright and license details.

include config.mk

MODE ?= release
CACHE_DIR ?= .build-cache

ABS_CACHE_DIR = $(shell readlink -f ${CACHE_DIR})
SUB_MAKEFILES = src/control/backlight.mk

${ABS_CACHE_DIR}:
	mkdir -p $@

build: ${SUB_MAKEFILES} | ${ABS_CACHE_DIR}
	@echo "--- BUILD SUB: ${notdir $<}"
	cd $(dir $<) && \
		make -f $(notdir $<) MODE=${MODE} CACHE_DIR=${ABS_CACHE_DIR}/$(dir $<)cache build

install_makefiles: ${SUB_MAKEFILES} | build
	@echo "--- INSTALL SUB: ${notdir $<}"
	cd $(dir $<) && \
		make -f $(notdir $<) MODE=${MODE} CACHE_DIR=${ABS_CACHE_DIR}/$(dir $<)cache install

install: install_makefiles
	mkdir -p ${DESTDIR}${PREFIX}/de-scripts
	rm -rf ${DESTDIR}${PREFIX}/de-scripts/*
	cp -r src/* ${DESTDIR}${PREFIX}/de-scripts

uninstall:
	rm -f ${DESTDIR}${PREFIX}/de-scripts

#.PHONY: all options clean build dist install uninstall