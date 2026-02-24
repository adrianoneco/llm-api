#!/bin/bash
echo "Starting LLM API..."
lms get $LLM_MODEL -y > /dev/null 2>&1

echo "Loading LLM model..."
lms load $LLM_MODEL > /dev/null 2>&1

echo "Starting LLM server..."   
lms server start --port $LLM_PORT > /dev/null 2>&1

exec npx vite --port 8443 --host