#!/bin/bash

docker run -it -u 0 --rm -v $(pwd)/temp:/opt/intel/openvino_2021.2.185/temp  openvino/ubuntu18_dev:latest bash && python3 $INTEL_OPENVINO_DIR/deployment_tools/tools/model_downloader/downloader.py --list $INTEL_OPENVINO_DIR/inference_engine/demos/python_demos/colorization_demo/models.lst &&\
python3 $INTEL_OPENVINO_DIR/deployment_tools/tools/model_downloader/converter.py --name colorization-v2 &&\
cp $INTEL_OPENVINO_DIR/public/colorization-v2/FP32/* $INTEL_OPENVINO_DIR/temp