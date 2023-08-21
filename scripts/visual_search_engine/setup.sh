#!/bin/bash

# Install Python
sudo apt-get update
sudo apt-get install python3.10
sudo apt-get install python3-pip

# Install Python packages
pip3 install -r searcher/requirements.txt

pip install ipykernel