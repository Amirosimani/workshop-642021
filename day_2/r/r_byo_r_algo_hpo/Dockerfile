FROM ubuntu:16.04

MAINTAINER Amazon SageMaker Examples <amazon-sagemaker-examples@amazon.com>

RUN apt-get -y update && apt-get install -y --no-install-recommends \
    wget \
    r-base \
    r-base-dev \
    apt-transport-https \
    ca-certificates \ 
    libcurl4-openssl-dev


RUN R -e "install.packages('https://cran.r-project.org/src/contrib/Archive/mda/mda_0.4-10.tar.gz', repos = NULL, type='source')"
RUN R -e "install.packages('https://cran.r-project.org/src/contrib/Archive/jsonlite/jsonlite_1.7.1.tar.gz', repos = NULL, type='source')"
RUN R -e "install.packages('plumber', dependencies=TRUE, repos='http://cran.rstudio.com/')"

# RUN R -e "install.packages('https://cran.r-project.org/src/contrib/Archive/plumber/plumber_1.0.0.tar.gz', repos = NULL, type='source')"


COPY mars.R /opt/ml/mars.R
COPY plumber.R /opt/ml/plumber.R

ENTRYPOINT ["/usr/bin/Rscript", "/opt/ml/mars.R", "--no-save"]
