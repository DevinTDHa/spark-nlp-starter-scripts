# Running the example with Docker

## 1. Build the image

```
docker build -t sparknlp:latest .
```

The build can be configure with the following Build Args (can be set with `--build-arg ARG=VALUE`):
| ARG                 | Default | Description                                                                                                                 |
| ------------------- | ------- | --------------------------------------------------------------------------------------------------------------------------- |
| `PYSPARK_VERSION`   | `3.0.2` | Sets PySpark version                                                                                                        |
| `SPARKNLP_VERSION`  | `3.1.0` | Sets Spark NLP version                                                                                                      |
| `INSTALL_NLU`       | `true`  | Installs [NLU](https://github.com/JohnSnowLabs/nlu)                                                                         |
| `DOWNLOAD_WORKSHOP` | `false` | Downloads the [Spark NLP Workshop](https://github.com/JohnSnowLabs/spark-nlp-workshop) into the image ( might take a while) |

## 2. Run the image

```bash
bash run_notebook.sh
```

This will run a notebook at http://localhost:8888 and the current folder will be mounted into the container.

### NLU

If you wish to run streamlit with NLU, you can run for example:

```bash
bash run_nlu.sh https://raw.githubusercontent.com/JohnSnowLabs/nlu/master/examples/streamlit/01_dashboard.py
```

Which will then run on http://localhost:8501.
