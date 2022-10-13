all:
	gprbuild

run:
	./bin/generator-main  ${NDDSHOME}/include/ndds/dds_ada/dds.ads
