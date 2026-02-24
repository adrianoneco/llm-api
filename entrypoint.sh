#!/bin/bash
cd /app
API_KEY=$(uuidgen -t | tr '[:lower:]' '[:upper:]')

if [ ! -f /app/.env ]; then
  echo "LLM_MODEL=${LLM_MODEL}" > /app/.env
  echo "LM_API_KEY=${LM_API_KEY:-$API_KEY}" >> /app/.env
fi

bun install --force

cd /root/.lmstudio/bin

echo "Starting LLM API..."
#/root/.lmstudio/bin/lms get $LLM_MODEL -y

echo "Loading LLM model..."
#/root/.lmstudio/bin/lms load $LLM_MODEL

echo "Starting LLM server..."   
/root/.lmstudio/bin/lms server start --port 1234

exec dotenv -e .env -- bunx vite --port 8443 --host 0.0.0.0