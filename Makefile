#!/usr/bin/make -f


VENDOR = $(shell lsb_release -i -s)
ifeq ($(VENDOR),Ubuntu)
DB_URL = https://autopkgtest.ubuntu.com/static/autopkgtest.db
else
DB_URL = TODO
endif


all: reports

autopkgtest.db:
	wget $(DB_URL)

reports: arch-speed

arch-speed: autopkgtest.db
	sqlite3 $< < $@.sql

.PHONY: reports arch-speed
