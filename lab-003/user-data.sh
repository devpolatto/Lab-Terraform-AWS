#!/bin/bash
sudo apt update
curl -fsSL https://get.docker.com -o get-docker.sh
sudo usermod -aG docker $USER