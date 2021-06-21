# Running the example with Docker
0. Make sure your licenses are in this sub folder (`Docker-x86_64`).
1. Build the image with
    ```
    docker build -t sparknlp:latest .
    ```
     - You can change the PySpark version by adding `--build-arg PYSPARK_VERSION=3.1.1` to the build command.
     - If you would like to include the Spark NLP and Spark OCR Workshop in the image, you can add `--build-arg DOWNLOAD_WORKSHOP=true` to the build command.
2. Run the image with
    ```bash
    docker run --rm -it -v $PWD:/home/johnsnow/data -p 8888:8888 sparknlp:latest
    ```
    This will run a notebook at localhost:8888 and the current folder will be mounted into the container. Downloaded jars will be available at `/jars/` in the container.