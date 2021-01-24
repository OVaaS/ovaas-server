#!/bin/bash

docker run -it -u 0 --rm \
-v $(pwd)/temp:/opt/intel/openvino_2021.1.110/temp \
openvino/ubuntu18_dev:2021.1 bash -c \
"python3 ./deployment_tools/tools/model_downloader/downloader.py --list ./inference_engine/demos/python_demos/colorization_demo/models.lst && \
python3 ./deployment_tools/tools/model_downloader/converter.py --name colorization-v2 && \
cp ./public/colorization-v2/FP32/* ./temp"

mkdir -p ./models/colorization-v2/1
mv ./temp/* ./models/colorization-v2/1
rm -r ./temp