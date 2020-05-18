#!/bin/bash
# author: cesar.alcancio@payclip.com
docker stop $(docker ps -a -q)
docker rm $(docker ps -a -q)
