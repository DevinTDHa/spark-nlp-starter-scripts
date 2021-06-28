#!/bin/bash
docker run --rm -it \
    -v $PWD:/home/johnsnow/data \
    -v $HOME/cache_pretrained:/home/johnsnow/cache_pretrained \
    -p 8888:8888 \
    sparknlp:latest