# Running the example with Docker
0. Make sure your licenses are in this sub folder.
1. Build the image with
    ```
    docker build -t sparknlp:latest .
    ```
2. Run the image with
    ```bash
    docker run --rm -it -v $PWD:/home/jovyan/data -p 8888:8888 sparknlp:latest
    ```
    This will run a notebook at localhost:8888 and the current folder will be mounted into the container. Downloaded jars will be available at `/jars/` in the container.