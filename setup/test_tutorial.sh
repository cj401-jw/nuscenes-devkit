#!/bin/bash
set -ex

# This script is to be executed inside a Docker container
source activate nuscenes

# Generate python script from Jupyter notebook and then copy into Docker image.
jupyter nbconvert --to python python-sdk/tutorials/nuscenes_basics_tutorial.ipynb || { echo "Failed to convert notebook to python script"; exit 1; }

# Remove extraneous matplot inline command and comment out any render* methods.
sed -i.bak "/get_ipython.*/d; s/\(nusc\.render.*\)/#\1/" python-sdk/tutorials/nuscenes_basics_tutorial.py || { echo "error in sed command"; exit 1; }

# Run tutorial
xvfb-run python python-sdk/tutorials/nuscenes_basics_tutorial.py

