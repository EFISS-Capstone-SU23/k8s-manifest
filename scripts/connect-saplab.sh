#!/bin/bash
set -x

ssh -v -L 0.0.0.0:6962:10.66.66.2:22 -L 0.0.0.0:5938:10.66.66.2:5938 -N localhost