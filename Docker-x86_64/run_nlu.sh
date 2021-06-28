#!/bin/bash
docker run --rm -it \
    -v $PWD:/home/johnsnow/data \
    -v $HOME/cache_pretrained:/home/johnsnow/cache_pretrained \
    -p 8501:8501 \
    sparknlp:latest \
    streamlit run --server.address 0.0.0.0 $@