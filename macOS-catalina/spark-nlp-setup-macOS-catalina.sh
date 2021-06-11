#!/bin/bash

PYSPARK="3.0.2"
SPARKNLP=$PUBLIC_VERSION
SPARKHOME="$PWD/spark-3.1.1-bin-hadoop2.7"
# export OCR_BASE_VERSION=$(echo "$OCR_VERSION" | grep -Eo "[0-9].[0-9].[0-9]")
# export OCR_SPARK_VERSION=$(echo "$OCR_VERSION" | grep -Eo "spark[0-9][0-9]")

echo "Setup PySpark $PYSPARK and Spark NLP $SPARKNLP and Spark OCR $OCR_VERSION and Spark NLP for Healthcare $JSL_VERSION"

JAVA_VER=$(java -version 2>&1 | sed -n ';s/.* version "\(.*\)\.\(.*\)\..*"/\1\2/p;')

if [[ $JAVA_VER -ne "18" ]]; then
  echo "Please install openjdk-8. Example with brew https://formulae.brew.sh/formula/openjdk@8"
fi

echo "Downloading Spark $PYSPARK"
if [[ "$PYSPARK" == "3.1"* ]]; then
  if [[ ! -e "spark-3.1.1-bin-hadoop2.7.tgz" ]]; then
    curl "https://downloads.apache.org/spark/spark-3.1.1/spark-3.1.1-bin-hadoop2.7.tgz" --output spark-3.1.1-bin-hadoop2.7.tgz
    tar -xf spark-3.1.1-bin-hadoop2.7.tgz > /dev/null
  fi
  SPARKHOME="$PWD/spark-3.1.1-bin-hadoop2.7"
elif [[ "$PYSPARK" == "3.0"* ]]; then
  if [[ ! -e "spark-3.0.2-bin-hadoop2.7.tgz" ]]; then
    curl "https://downloads.apache.org/spark/spark-3.0.2/spark-3.0.2-bin-hadoop2.7.tgz" --output spark-3.0.2-bin-hadoop2.7.tgz
    tar -xf spark-3.0.2-bin-hadoop2.7.tgz > /dev/null
  fi
  SPARKHOME="$PWD/spark-3.0.2-bin-hadoop2.7"
elif [[ "$PYSPARK" == "2"* ]]; then
  if [[ ! -e "spark-2.4.7-bin-hadoop2.7.tgz" ]]; then
    curl "https://downloads.apache.org/spark/spark-2.4.7/spark-2.4.7-bin-hadoop2.7.tgz" --output spark-2.4.7-bin-hadoop2.7.tgz
    tar -xf spark-2.4.7-bin-hadoop2.7.tgz > /dev/null
  fi
  SPARKHOME="$PWD/spark-2.4.7-bin-hadoop2.7"
else
  if [[ ! -e "spark-3.1.1-bin-hadoop2.7.tgz" ]]; then
    curl "https://downloads.apache.org/spark/spark-3.1.1/spark-3.1.1-bin-hadoop2.7.tgz" --output spark-3.1.1-bin-hadoop2.7.tgz
    tar -xf spark-3.1.1-bin-hadoop2.7.tgz > /dev/null
  fi
  SPARKHOME="$PWD/spark-3.1.1-bin-hadoop2.7"
fi

export SPARK_HOME=$SPARKHOME

# Install pyspark spark-nlp
! pip3 install -U pip
! pip3 install --upgrade pyspark==$PYSPARK spark-nlp==$SPARKNLP findspark
! pip3 install --upgrade spark-nlp-jsl==$JSL_VERSION  --extra-index-url https://pypi.johnsnowlabs.com/$SECRET
! pip3 install --upgrade scikit-image pillow==8.1.2 implicits
! pip3 install https://pypi.johnsnowlabs.com/$JSL_OCR_SECRET/spark-ocr/spark-ocr-$OCR_BASE_VERSION.$OCR_SPARK_VERSION.tar.gz

# NLP Jar
#curl https://s3.amazonaws.com/auxdata.johnsnowlabs.com/public/jars/spark-nlp-assembly-$SPARKNLP.jar
## NLP Healthcare Jar
curl https://pypi.johnsnowlabs.com/$SECRET/spark-nlp-jsl-$JSL_VERSION.jar --output spark-nlp-jsl-$JSL_VERSION.jar
## OCR Jar
OCR_JAR=spark-ocr-assembly-$OCR_BASE_VERSION-$OCR_SPARK_VERSION.jar
curl https://pypi.johnsnowlabs.com/$JSL_OCR_SECRET/jars/$OCR_JAR --output $OCR_JAR