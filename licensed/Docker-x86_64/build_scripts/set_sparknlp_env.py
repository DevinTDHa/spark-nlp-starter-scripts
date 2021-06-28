import json
import os
import re
import os.path

sparknlp_versions = {"PUBLIC_VERSION": "3.1.0"}

WORKDIR = "/build_scripts"

with open(WORKDIR + "/spark_nlp_for_healthcare.json", "r") as f:
    sparknlp_versions.update(json.load(f).items())

with open(WORKDIR + "/spark_ocr.json", "r") as f:
    ocr_version_pattern = re.compile(r"(\d+\.\d+\.\d+).*?(spark\d+)")
    for k, v in json.load(f).items():
        sparknlp_versions[k] = v
        if k == "SPARK_OCR_sparknlp_versions":
            k = "JSL_OCR_sparknlp_versions"
            sparknlp_versions[k] = v
        if k == "JSL_OCR_SECRET":
            k = "SPARK_OCR_SECRET"
            sparknlp_versions[k] = v
        if k == "OCR_VERSION":
            match = ocr_version_pattern.findall(v)
            if match:
                ocr_base_version, ocr_spark_version = match[0]
                sparknlp_versions["OCR_BASE_VERSION"] = ocr_base_version
                sparknlp_versions["OCR_SPARK_VERSION"] = ocr_spark_version

with open(WORKDIR + "/SPARKNLP_VERSIONS", "w+") as f:
    for k, v in sparknlp_versions.items():
        f.write(f"export {k}={v}\n")
