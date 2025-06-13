# perconf - percentage configuration utility
# See LICENSE file for copyright and license details.

include config.mk

BIN_NAME = backlight-setter

MODE ?= release
CACHE_DIR ?= .build-cache
PREFIX ?= .

OUT_DIR = ${PREFIX}/${HELPERS_DIR}/${BIN_NAME}

SRC = backlight-setter.c
HEADERS = 
OBJ = $(addprefix ${CACHE_DIR}/,${SRC:.c=.o})

ifeq (${MODE}, release)
	CFLAGS += ${RELEASE_CFLAGS}
endif

options:
	@echo --- ${BIN_NAME} build options \(${MODE}\):
	@echo "CFLAGS   = ${CFLAGS} ${DEFFLAGS}"
	@echo "LDFLAGS  = ${LDFLAGS}"
	@echo "CC       = ${CC}"

${CACHE_DIR}:
	mkdir -p $@

${CACHE_DIR}/%.o: %.c ${HEADERS} config.mk | ${CACHE_DIR}
	${CC} -c ${CFLAGS} ${DEFFLAGS} $< -o $@

${CACHE_DIR}/${BIN_NAME}: ${OBJ}
	${CC} -o $@ ${OBJ} ${LDFLAGS}

build: | ${CACHE_DIR}/${BIN_NAME} options

install: build
	mkdir -p ${OUT_DIR}
	cp ${CACHE_DIR}/${BIN_NAME} ${OUT_DIR}/${BIN_NAME}
	chown root:root ${OUT_DIR}/${BIN_NAME}
	chmod 755 ${OUT_DIR}/${BIN_NAME}
	chmod +s ${OUT_DIR}/${BIN_NAME}

clean:
	rm -rf ${CACHE_DIR}
