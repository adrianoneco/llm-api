#!/bin/bash
lms get liquid/lfm2-350m -y

lms load liquid/lfm2-350m

lms server start --port 8443

wait $!