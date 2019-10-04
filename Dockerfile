FROM container-registry.phenomenal-h2020.eu/phnmnl/rbase:dev_v3.4.4-1xenial0_cv1.0.20

MAINTAINER PhenoMeNal-H2020 Project (phenomenal-h2020-users@googlegroups.com)

LABEL software="XCMS"
LABEL software.version="1.53.1"
LABEL version="0.1"
LABEL Description="XCMS: Framework for processing and visualization of chromatographically separated and single-spectra mass spectral data."
LABEL website="https://github.com/sneumann/xcms"
LABEL documentation="https://github.com/phnmnl/container-xcms/blob/master/README.md"
LABEL license="https://github.com/phnmnl/container-midcor/blob/master/License.txt"
LABEL tags="Metabolomics"

# Install packages for compilation
RUN apt-get -y update && apt-get -y --no-install-recommends install make gcc gfortran g++ libnetcdf-dev libxml2-dev libblas-dev liblapack-dev libssl-dev pkg-config git && \
    R -e 'source("https://bioconductor.org/biocLite.R"); biocLite(c("MSnbase","mzR","MassSpecWavelet","S4Vectors","BiocStyle","faahKO","msdata"))' && \
    R -e 'source("https://bioconductor.org/biocLite.R");biocLite(c("lattice","RColorBrewer","plyr","RANN","multtest","knitr","ncdf4","microbenchmark","RUnit"))' && \
    R -e 'source("https://bioconductor.org/biocLite.R");biocLite("devtools")' && \
    R -e 'source("https://bioconductor.org/biocLite.R");biocLite("ncdf4")' && \
    R -e 'library(devtools); install_github(repo="sneumann/xcms", ref="d9baa6ca364f4dd197a9eedd361869cf0787dbc3")' && \
    R -e 'library(devtools); install_github(repo="sneumann/CAMERA", ref="cbc9cdb2eba6438434c27fec5fa13c9e6fdda785")' && \
    apt-get -y --purge --auto-remove remove make gcc gfortran g++ libblas-dev liblapack-dev && \
    apt-get -y clean && apt-get -y autoremove && rm -rf /var/lib/{cache,log}/ /tmp/* /var/tmp/*

# Install Python
RUN apt-get -y update && apt-get -y --no-install-recommends install python3 python3-pip libqtgui4 python3-setuptools
# install pyopenms
RUN pip3 install -Iv pyopenms==2.1.0 numpy

# Add scripts to container
ADD scripts/*.r /usr/local/bin/
RUN chmod +x /usr/local/bin/*.r

# Add testing to container
# ADD runTest1.sh /usr/local/bin/runTest1.sh
