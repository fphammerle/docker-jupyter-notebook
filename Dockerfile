FROM debian:bullseye

RUN apt-get update \
    && apt-get install --yes --no-install-recommends \
        jupyter-notebook \
        r-cran-irkernel \
        `# https://github.com/rOpenGov/eurostat/blob/master/DESCRIPTION` \
        r-cran-broom \
        r-cran-classint \
        r-cran-dplyr \
        r-cran-httr \
        r-cran-jsonlite \
        r-cran-rcolorbrewer \
        r-cran-readr \
        r-cran-sf \
        r-cran-sp \
        r-cran-stringi \
        r-cran-stringr \
        r-cran-tibble \
        r-cran-tidyr \
        `# https://cran.r-project.org/web/packages/RefManageR/index.html ` \
        r-cran-bibtex \
        r-cran-lubridate \
        r-cran-xml2

# TODO merge
RUN apt-get update \
    && apt-get install --yes --no-install-recommends \
        curl \
        python3-geopandas \
        python3-xlrd \
        unzip
RUN apt-get update \
    && apt-get install --yes --no-install-recommends \
        python3-distutils `# pyproj`

RUN useradd --create-home --groups staff notebook
USER notebook

RUN Rscript -e 'install.packages("eurostat")'

VOLUME /home/notebook
WORKDIR /home/notebook
CMD ["jupyter", "notebook", "--ip=0.0.0.0"]
