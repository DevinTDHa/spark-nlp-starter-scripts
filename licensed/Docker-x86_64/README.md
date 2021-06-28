# Running the example with Docker
0. Make sure your licenses are in this sub folder (`Docker-x86_64`).
1. Build the image with
    ```
    docker build -t sparknlp:latest .
    ```

    The build can be configure with the following Build Args (can be set with `--build-arg ARG=VALUE`):
    | ARG                 | Default | Description                                                                                                                 |
    | ------------------- | ------- | --------------------------------------------------------------------------------------------------------------------------- |
    | `PYSPARK_VERSION`   | `3.1.1` | Sets PySpark version                                                                                                        |
    | `DOWNLOAD_WORKSHOP` | `false` | Downloads the [Spark NLP Workshop](https://github.com/JohnSnowLabs/spark-nlp-workshop) into the image ( might take a while) |
2. Run the image with
    ```bash
    docker run --rm -it -v $PWD:/home/johnsnow/data -p 8888:8888 sparknlp:latest
    ```
    This will run a notebook at localhost:8888 and the current folder will be mounted into the container. Downloaded jars will be available at `/jars/` in the container.