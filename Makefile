-include Makefile.conf
PREFIX?=${NDDSHOME}
GPR_PROJECT_PATH?=${NDDSHOME}/lib/gnat

all:compile test

compile:
	gprbuild -P ddsarchitectspy.gpr


test:compile
	bin/dds-architecurespy -t 2.0

install:
	gprinstall ddsarchitectspy.gpr --prefix=${PREFIX} --mode=usage --create-missing-dirs --no-manifest --no-project --force

Makefile.conf:Makefile
	@echo "export PATH=${PATH}">$@
	@echo "export NDDSHOME=${NDDSHOME}">>$@
	@echo "export GPR_PROJECT_PATH=${NDDSHOME}/lib/gnat">>$@

clean:
	git clean -xdff

