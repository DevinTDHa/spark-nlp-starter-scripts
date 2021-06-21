#Download base image ubuntu 18.04
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
    apt-get install ca-certificates-java && \
    apt-get clean && \
    update-ca-certificates -f;
# Setup JAVA_HOME -- useful for docker commandline
ENV JAVA_HOME /usr/lib/jvm/java-8-openjdk-amd64/
RUN export JAVA_HOME

RUN echo "export JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64/" >> ~/.bashrc

RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN pip3 install --upgrade pip

ARG PYSPARK_VERSION=3.1.1
ENV PYSPARK=${PYSPARK_VERSION}

RUN pip3 install --no-cache-dir pyspark==${PYSPARK_VERSION} notebook==5.* numpy pandas findspark implicits scikit-image pillow termcolor

RUN chown -R ${NB_UID} ${HOME}

# Set licensed package versions in environment variable from json
RUN mkdir -p /build_scripts
COPY build_scripts /build_scripts
COPY spark_nlp_for_healthcare.json /build_scripts/spark_nlp_for_healthcare.json
COPY spark_ocr.json /build_scripts/spark_ocr.json
RUN python3 /build_scripts/set_sparknlp_env.py

# Setup for licensed modules
RUN bash /build_scripts/install_packages.sh

# Specify the default command to run
USER ${NB_USER}
WORKDIR ${HOME}

ARG DOWNLOAD_WORKSHOP=false
RUN ! $DOWNLOAD_WORKSHOP || \
    (git clone https://github.com/JohnSnowLabs/spark-nlp-workshop.git && \
    git clone https://github.com/JohnSnowLabs/spark-ocr-workshop.git)

COPY build_scripts/start_notebook.sh start_notebook.sh
EXPOSE 8888
CMD ["bash", "start_notebook.sh"]