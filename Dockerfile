ARG BASE_CONTAINER=jupyter/minimal-notebook
FROM $BASE_CONTAINER

LABEL maintainer="GIFCT <tech@gifct.org>"

USER root

COPY ./requirements.txt /var/www/requirements.txt

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    ffmpeg \
    tesseract-ocr -y
RUN pip install -r /var/www/requirements.txt
RUN pip install pdqhash>=0.2.2  # --no-cache-dir --no-binary :all: maybe required if pqdhash is not correctly compiling

RUN apt-get clean && rm -rf /var/lib/apt/lists/* && \
    conda clean --all -f -y

# Import matplotlib the first time to build the font cache.
ENV XDG_CACHE_HOME="/home/${NB_USER}/.cache/"

ENV JUPYTER_ENABLE_LAB="yes"

RUN MPLBACKEND=Agg python -c "import matplotlib.pyplot" && \
    fix-permissions "/home/${NB_USER}"

ENTRYPOINT ["jupyter", "lab", "--ip=0.0.0.0", "--allow-root"]

USER $NB_UID

WORKDIR $HOME
