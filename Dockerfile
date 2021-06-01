ARG BASE_CONTAINER=jupyter/minimal-notebook
FROM $BASE_CONTAINER

LABEL maintainer="GIFCT <tech@gifct.org>"

USER root

COPY ./environment.yml ./requirements.txt /tmp/

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    ffmpeg \
    tesseract-ocr -y
RUN apt-get clean && rm -rf /var/lib/apt/lists/*

RUN conda update --name base --channel defaults conda && \
    conda install widgetsnbextension && \
    conda env create --file /tmp/environment.yml --force && \
    conda clean --all --yes

RUN pip install -r /tmp/requirements.txt
RUN pip install pdqhash --no-cache-dir --no-binary :all:
RUN pip install threatexchange --no-cache-dir

ENV JUPYTER_ENABLE_LAB="yes"

ENTRYPOINT ["jupyter", "lab", "--ip=0.0.0.0", "--allow-root"]

USER $NB_UID

WORKDIR $HOME
