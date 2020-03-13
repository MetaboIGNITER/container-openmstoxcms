Bootstrap: docker
From: container-registry.phenomenal-h2020.eu/phnmnl/rbase:dev_v3.4.4-1xenial0_cv1.0.20
%files
scripts/*.r /usr/local/bin/
%labels
MAINTAINER PhenoMeNal-H2020 Project (phenomenal-h2020-users@googlegroups.com)
software="XCMS"
software.version="1.53.1"
version="0.1"
Description="XCMS: Framework for processing and visualization of chromatographically separated and single-spectra mass spectral data."
website="https://github.com/sneumann/xcms"
documentation="https://github.com/phnmnl/container-xcms/blob/master/README.md"
license="https://github.com/phnmnl/container-midcor/blob/master/License.txt"
tags="Metabolomics"
%post



# Install packages for compilation
apt-get -y update && apt-get -y --no-install-recommends install make gcc gfortran g++ libnetcdf-dev libxml2-dev libblas-dev liblapack-dev libssl-dev pkg-config git && \
R -e 'source("https://bioconductor.org/biocLite.R"); biocLite(c("MSnbase","mzR","MassSpecWavelet","S4Vectors","BiocStyle","faahKO","msdata"))' && \
R -e 'source("https://bioconductor.org/biocLite.R");biocLite(c("lattice","RColorBrewer","plyr","RANN","multtest","knitr","ncdf4","microbenchmark","RUnit"))' && \
R -e 'source("https://bioconductor.org/biocLite.R");biocLite("devtools")' && \
R -e 'source("https://bioconductor.org/biocLite.R");biocLite("ncdf4")' && \
R -e 'library(devtools); install_github(repo="sneumann/xcms", ref="d9baa6ca364f4dd197a9eedd361869cf0787dbc3")' && \
R -e 'library(devtools); install_github(repo="sneumann/CAMERA", ref="cbc9cdb2eba6438434c27fec5fa13c9e6fdda785")' && \
apt-get -y --purge --auto-remove remove make gcc gfortran g++ libblas-dev liblapack-dev && \
apt-get -y clean && apt-get -y autoremove && rm -rf /var/lib/{cache,log}/ /tmp/* /var/tmp/*

# Install Python
apt-get -y update && apt-get -y --no-install-recommends install python3 python3-pip libqtgui4 python3-setuptools
# install pyopenms
pip3 install -Iv pyopenms==2.1.0 numpy

# Add scripts to container
chmod +x /usr/local/bin/*.r

# Add testing to container
# ADD runTest1.sh /usr/local/bin/runTest1.sh
%runscript
exec /bin/bash "$@"
%startscript
exec /bin/bash "$@"
