#!/bin/bash

mkdir gpg3100
mkdir gpg3300
mkdir gpg6204

mv gpg3100_x86_64_056046.tgz gpg3100
mv gpg3300_x86_64_047043.tgz gpg3300
mv gpg6204_x86_64_044020.tgz gpg6204

cd gpg3100
tar xvf gpg3100_x86_64_056046.tgz
sudo bash install
cd ..

cd gpg3300
tar xvf gpg3300_x86_64_047043.tgz
sudo bash install
cd ..

cd gpg6204
tar xvf gpg6204_x86_64_044020.tgz
sudo bash install
cd ..
