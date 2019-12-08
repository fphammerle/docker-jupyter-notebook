FROM debian:bullseye

RUN apt-get update \
    && apt-get install --yes --no-install-recommends \
        curl \
        jupyter-notebook \
        python3-distutils `# pyproj` \
        python3-geopandas \
        python3-xlrd \
        r-cran-irkernel \
        unzip \
        `# https://github.com/ResidentMario/geoplot/blob/master/setup.py` \
        python3-cartopy \
        python3-descartes \
        python3-matplotlib \
        python3-pip \
        python3-seaborn \
        python3-setuptools \
        python3-wheel \
        `# mapclassify->geoplot` \
        python3-deprecated \
        `# contextily->geoplot` \
        python3-geopy \
        python3-joblib \
        python3-pillow \
        python3-rasterio \
        python3-requests \
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
        python3-feather-format \
        `# https://cran.r-project.org/web/packages/geojsonio/index.html` \
        r-cran-maptools \
        r-cran-rgdal \
        r-cran-v8 \
        `# geojson->geojsonio ` \
        r-cran-lazyeval \
        `# protolite->geojson->geojsonio` \
        g++ \
        libprotobuf-dev \
        make
RUN apt-get update \
    && apt-get install --yes --no-install-recommends \
        `# rgeos->geojsonio` \
        libgeos-dev \
        `# jqr->geojsonio` \
        libjq-dev \
        `# protolite->geojson->geojsonio` \
        protobuf-compiler

RUN chgrp staff /usr/local/bin `# meranctile` \
    && chmod g+ws /usr/local/bin \
    && useradd --create-home --groups staff notebook
USER notebook

RUN pip3 install --system geoplot

RUN Rscript -e 'install.packages("geojsonio")'
RUN Rscript -e 'install.packages("eurostat")'

VOLUME /home/notebook
WORKDIR /home/notebook
CMD ["jupyter", "notebook", "--ip=0.0.0.0"]
