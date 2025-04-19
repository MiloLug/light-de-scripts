# perconf - percentage configuration utility
# See LICENSE file for copyright and license details.

include config.mk

MODE ?= release
CACHE_DIR ?= .build-cache

ABS_CACHE_DIR = $(shell readlink -f ${CACHE_DIR})
SUB_MAKEFILES = src/control/backlight.mk
CACHE_MAKEFILES = $(addprefix ${ABS_CACHE_DIR}/, ${SUB_MAKEFILES})

${ABS_CACHE_DIR}:
	mkdir -p $@

${CACHE_MAKEFILES}: ${SUB_MAKEFILES} | ${ABS_CACHE_DIR}
	mkdir -p $(dir $@)
	cp $< $@
	make -C $(dir $@) -f $@ MODE=${MODE} CACHE_DIR=$(dir $@)/cache

build: ${CACHE_MAKEFILES}

install: build
	mkdir -p ${DESTDIR}${PREFIX}/de-scripts
	rm -rf ${DESTDIR}${PREFIX}/de-scripts/*
	cp -r src/* ${DESTDIR}${PREFIX}/de-scripts

uninstall:
	rm -f ${DESTDIR}${PREFIX}/de-scripts

#.PHONY: all options clean build dist install uninstall