#!/bin/bash

docker login

docker build -t jscdroiddev/jsc-hack-tools:latest . && docker push jscdroiddev/jsc-hack-tools:latest
