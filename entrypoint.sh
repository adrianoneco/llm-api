#!/bin/bash
PATH="/root/.lmstudio/bin:$PATH"
source /root/.bashrc

echo "Starting LLM API..."
lms get $LLM_MODEL -y

echo "Loading LLM model..."
lms load $LLM_MODEL

echo "Starting LLM server..."   
lms server start --port 1234

exec bunx vite --port 8443 --host