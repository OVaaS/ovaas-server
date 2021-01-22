#!/bin/bash

# Download url
URL=https://download.01.org/opencv/2020/openvinotoolkit/2020.4/open_model_zoo/models_bin/1

# Download human-pose-estimation model
HUMAN_POSE=human-pose-estimation-0001

curl --create-dirs \
$URL/$HUMAN_POSE/FP32/$HUMAN_POSE.xml \
$URL/$HUMAN_POSE/FP32/$HUMAN_POSE.bin \
-o models/human-pose-estimation/1/$HUMAN_POSE.xml \
-o models/human-pose-estimation/1/$HUMAN_POSE.bin

# Download handwritten-japanese-recognition model
HANDWRITTEN=handwritten-japanese-recognition-0001

curl --create-dirs \
$URL/$HANDWRITTEN/FP32/$HANDWRITTEN.xml \
$URL/$HANDWRITTEN/FP32/$HANDWRITTEN.bin \
-o models/handwritten-japanese-recognition/1/$HANDWRITTEN.xml \
-o models/handwritten-japanese-recognition/1/$HANDWRITTEN.bin
