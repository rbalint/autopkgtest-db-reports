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

reports: arch-speed.report pass-analysis.report package-stats.report # i386-false-passes.report

%.report: %.sql autopkgtest.db
	sqlite3 autopkgtest.db < $< 2>&1 | tee $@

clean:
	rm *.report

.PHONY: clean reports

