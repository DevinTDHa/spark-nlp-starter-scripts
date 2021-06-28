#!/bin/bash
source /build_scripts/SPARKNLP_VERSIONS
pip3 install --no-cache-dir --upgrade --extra-index-url https://pypi.johnsnowlabs.com/$SECRET spark-nlp-jsl==$JSL_VERSION
pip3 install --no-cache-dir --upgrade spark-nlp==$PUBLIC_VERSION
pip3 install --no-cache-dir --upgrade --no-deps https://pypi.johnsnowlabs.com/$JSL_OCR_SECRET/spark-ocr/spark-ocr-$OCR_BASE_VERSION.$OCR_SPARK_VERSION.tar.gz

mkdir -p jars
wget -P /jars https://pypi.johnsnowlabs.com/$SECRET/spark-nlp-jsl-$JSL_VERSION.jar
wget -P /jars https://pypi.johnsnowlabs.com/$JSL_OCR_SECRET/jars/spark-ocr-assembly-$OCR_BASE_VERSION-$OCR_SPARK_VERSION.jar