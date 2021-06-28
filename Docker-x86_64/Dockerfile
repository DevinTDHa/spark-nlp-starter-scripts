# Download base image ubuntu 18.04
FROM ubuntu:18.04

ENV NB_USER johnsnow
ENV NB_UID 1000
ENV HOME /home/${NB_USER}

ENV PYSPARK_PYTHON=python3
ENV PYSPARK_DRIVER_PYTHON=python3

RUN apt-get update && apt-get install -y \
    tar \
    wget \
    bash \
    rsync \
    gcc \
    libfreetype6-dev \
    libhdf5-serial-dev \
    libpng-dev \
    libzmq3-dev \
    python3 \
    python3-dev \
    python3-pip \
    unzip \
    pkg-config \
    software-properties-common \
    graphviz \
    git

RUN adduser --disabled-password \
    --gecos "Default user" \
    --uid ${NB_UID} \
    ${NB_USER}

# Install OpenJDK-8
RUN apt-get update && \
    apt-get install -y openjdk-8-jdk && \
    apt-get install -y ant && \
    apt-get clean;

# Fix certificate issues
RUN apt-get update && \
    apt-get install ca-certificates ca-certificates-java && \
    apt-get clean && \
    update-ca-certificates -f;

# Setup JAVA_HOME -- useful for docker commandline
ENV JAVA_HOME /usr/lib/jvm/java-8-openjdk-amd64/
RUN export JAVA_HOME

RUN echo "export JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64/" >> ~/.bashrc

RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN pip3 install --no-cache-dir --upgrade pip

# Spark NLP Setup
# PySpark and dependencies
#TODO 3.0.2
ARG PYSPARK_VERSION=3.0.1
ENV PYSPARK=${PYSPARK_VERSION}
RUN pip3 install --no-cache-dir pyspark==${PYSPARK_VERSION} notebook==5.* numpy pandas findspark termcolor

# Spark NLP
ARG SPARKNLP_VERSION=3.1.0
RUN pip3 install --no-cache-dir spark-nlp==${SPARKNLP_VERSION} spark-nlp-display

# NLU
ARG INSTALL_NLU=true
RUN ! ${INSTALL_NLU} || pip3 install --no-cache-dir nlu streamlit sklearn plotly

# Resolve locale issues
ENV LC_ALL=C.UTF-8 \
    LANG=C.UTF-8

RUN chown -R ${NB_UID} ${HOME}

USER ${NB_USER}
WORKDIR ${HOME}

# Workshop
ARG DOWNLOAD_WORKSHOP=false
RUN ! ${DOWNLOAD_WORKSHOP} || git clone https://github.com/JohnSnowLabs/spark-nlp-workshop.git

RUN mkdir -p build_scripts
COPY ./build_scripts ./build_scripts
EXPOSE 8888
CMD ["bash", "build_scripts/start_notebook.sh"]