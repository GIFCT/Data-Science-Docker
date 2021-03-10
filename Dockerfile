ARG BASE_CONTAINER=jupyter/minimal-notebook
FROM $BASE_CONTAINER

LABEL maintainer="GIFCT <tech@gifct.org>"

USER root

# ffmpeg for matplotlib
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    ffmpeg \
    && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

USER $NB_UID

RUN pip install --quiet \
    'threatexchange'

# Install Python 3 packages
RUN conda install --quiet --yes \
    'beautifulsoup4=4.9.*' \
    'conda-forge::blas=*=openblas' \
    'ipywidgets=7.6.*' \
    'ipympl=0.6.*'\
    'matplotlib-base=3.3.*' \
    'pandas=1.2.*' \
    'numpy=1.19.*' \
    'folium=0.12.*' \
    'patsy=0.5.*' \
    'pytables=3.6.*' \
    'scikit-image=0.18.*' \
    'scikit-learn=0.24.*' \
    'scipy=1.6.*' \
    'sqlalchemy=1.3.*' \
    'geopy=2.1.*' \
    'pygeohash=1.2.*' \
    'chart_studio=1.1.*' \
    'bokeh=2.3.*' \
    'keras=2.4.*'\
    'tensorflow=2.4.*' \
    'seaborn=0.11.*' \
    'plotly=4.14.*' \
    'nltk=3.*' \
    'wordcloud-1.8.*' \
    'statsmodels=0.12.*' &&\
    conda clean --all -f -y && \
    fix-permissions "${CONDA_DIR}" && \
    fix-permissions "/home/${NB_USER}",

# Import matplotlib the first time to build the font cache.
ENV XDG_CACHE_HOME="/home/${NB_USER}/.cache/"

ENV JUPYTER_ENABLE_LAB="yes"

RUN MPLBACKEND=Agg python -c "import matplotlib.pyplot" && \
    fix-permissions "/home/${NB_USER}"

ENTRYPOINT ["jupyter", "lab", "--ip=0.0.0.0", "--allow-root"]

USER $NB_UID

WORKDIR $HOME
