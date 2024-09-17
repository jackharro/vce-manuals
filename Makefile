.PHONY: instal install build all clean uninstal uninstall

SHELL := /bin/bash
LOCAL_DEST := ./local/share/man

# CONTRIBUTING: must update these lines
# TODO: keep only TRACKED_TARGET but remove leading target/ in uninstal 
TRACKED_DESTINATION := man7/vce.gz
TRACKED_TARGET := target/man7/vce.gz

all: instal

instal: build
	-echo $${DESTINATION:=$(LOCAL_DEST)} > /dev/null;\
	echo $${DESTINATION} | \
		grep 'man' > /dev/null || \
		(echo warning: '$$DESTINATION' does not include word \'man\' && \
		read -p 'Enter to continue, SIGTERM to cancel') ;\
	mkdir -p $${DESTINATION} ;\
	cp -ri ./target/* $${DESTINATION}

# Our files
build: clean $(TRACKED_TARGET)
	echo Build complete

target/man7/vce.gz: target
	touch target/man7/vce ;\
	gzip target/man7/vce

target:
	-mkdir -p ./target/man7

clean: 
	-rm -r ./target

uninstal:
	cd $${DESTINATION:-$(LOCAL_DEST)} ;\
	rm -r $(TRACKED_DESTINATION)

install: instal

uninstall: uninstal
