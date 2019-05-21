#!/bin/bash

git clone https://github.com/google/jsonnet.git jsonnet_git
cd jsonnet_git
make
mv jsonnet ../
mv jsonnetfmt ../
cd ../
rm -rf jsonnet_git
