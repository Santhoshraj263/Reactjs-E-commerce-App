#!/bin/bash
set -e

IMAGE_NAME="myreactimage"

sudo docker build -t $IMAGE_NAME .

