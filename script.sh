#!/bin/bash

# Install for using apt-get over https
sudo apt-get update -y
sudo apt-get install -y \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg-agent \
    software-properties-common
# Add docker GPG key
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo apt-key fingerprint 0EBFCD88
# Add Docker repo
sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"
# Install docker
sudo apt-get update  -y
sudo apt-get install -y docker-ce docker-ce-cli containerd.io

# Create docker user group
sudo groupadd docker
# Add current user to docker group
sudo usermod -aG docker $USER

# Install docker compose
sudo curl -L --fail https://github.com/docker/compose/releases/download/1.28.0/run.sh -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
sudo ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose

# Download url
URL=https://download.01.org/opencv/2020/openvinotoolkit/2020.4/open_model_zoo/models_bin/1

# Download human-pose-estimation model
HUMAN_POSE=human-pose-estimation-0001

curl --create-dirs \
$URL/$HUMAN_POSE/FP32/$HUMAN_POSE.xml \
$URL/$HUMAN_POSE/FP32/$HUMAN_POSE.bin \
-o ./models/human-pose-estimation/1/$HUMAN_POSE.xml \
-o ./models/human-pose-estimation/1/$HUMAN_POSE.bin

# Download handwritten-japanese-recognition model
HANDWRITTEN=handwritten-japanese-recognition-0001

curl --create-dirs \
$URL/$HANDWRITTEN/FP32/$HANDWRITTEN.xml \
$URL/$HANDWRITTEN/FP32/$HANDWRITTEN.bin \
-o ./models/handwritten-japanese-recognition/1/$HANDWRITTEN.xml \
-o ./models/handwritten-japanese-recognition/1/$HANDWRITTEN.bin

# Download and convert colorization model

docker run -it -u 0 --rm \
-v $(pwd)/temp:/opt/intel/openvino_2021.1.110/temp \
openvino/ubuntu18_dev:2021.1 bash -c \
"python3 ./deployment_tools/tools/model_downloader/downloader.py --list ./inference_engine/demos/python_demos/colorization_demo/models.lst && \
python3 ./deployment_tools/tools/model_downloader/converter.py --name colorization-v2 && \
cp ./public/colorization-v2/FP32/* ./temp"

mkdir -p ./models/colorization-v2/1
mv ./temp/ ./models/colorization-v2/1
rm -r ./temp
