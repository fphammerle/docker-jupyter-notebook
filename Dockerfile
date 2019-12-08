FROM debian:bullseye

RUN apt-get update \
    && apt-get install --yes --no-install-recommends \
        jupyter-notebook

RUN useradd --create-home notebook
USER notebook

VOLUME /home/notebook
WORKDIR /home/notebook
CMD ["jupyter", "notebook", "--ip=0.0.0.0"]
