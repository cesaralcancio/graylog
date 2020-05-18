#!/bin/bash
# author: cesar.alcancio@gmail.com
docker stop $(docker ps -a -q)
docker rm $(docker ps -a -q)
