#!/bin/sh

docker build . -t bazel-nix:latest
docker run -v $(pwd)/workspace:/workspace -w /workspace -it bazel-nix:latest  /bin/bash 

