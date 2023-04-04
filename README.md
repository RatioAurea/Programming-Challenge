This application consists of three Docker containers linked through a Docker network. The main task of this system is to classify ECG data using ResNet deep learning model. It consists of the following Docker images: 
- jupyter/datascience-notebook: provides Jupyter Lab environment in which the code is written (in Python). The code is taken from https://github.com/spdrnl/ecg/blob/master/ECG.ipynb and adapted for new data.
- mongo: database that contains the relevant data (data taken from https://zenodo.org/record/5711347#.ZCyzdXtByMp)
- mongo-express: an interactive web-based interface for managing MongoDB databases
The containers of this multi-container Docker application are run using the docker-compose tool.

This repository contains the following files:
- composer.yml - YAML file which defines services and connections between them that will be used in the Docker application (in this case jupyter/datascience-notebook, mongo, and mongo-express). It should be run using the docker-compose command.
- Dockerfile - config file with instructions for the composer.yml file to build a Docker image based on jupyter/datascience-notebook and install the following additional requirements (not included in jupyter/datascience-notebook): pymongo, tensorflow and tensorflow_addons
- ECGcollection - ECG database in JSON format which is imported into the mongo container during the running of the Docker application
- mongo-init.sh - bash script executed during initialization of mongo container that imports ECG database using the mongoimport tool
- myapp.ipynb - jupyter notebook that classifies ECG data using ResNet deep learning model

Instructions on how to run this Docker application:
- Download Docker from https://www.docker.com/. 
- Clone this git repo with git lfs (https://git-lfs.com/) running the following command: "git lfs clone https://github.com/RatioAurea/Programming-Challenge.git". The ECGcollection file is larger than 100MB so it is stored in the repository using Git Large File Storage. Another option is to manually download the ECGcollection file from the repository.
- Run the following command: "docker-compose -f composer.yml up -d --build". This might take a while because Docker has to pull the needed images from Docker Hub library if they do not already exist on the host machine (jupyter/datascience-notebook and tensorflow package are rather large, ca. 6GB and 600MB respectively).
- Go to localhost:8888 address in any web browser to open Jupyter Lab environment (the password for entering Jupyter Lab is: password).
- Open the work directory and navigate to myapp.ipynb file.
- (optional) Go to localhost:8081 address in any web browser to open a web-based MongoDB interface called Mongo Express to see the imported ECG database.
- Run the code in Jupyter Lab to make and train ResNet deep learning model on the imported database for classifying ECG samples.
- In the terminal run the following command to exit the Docker application: "docker-compose -f composer.yml down".
