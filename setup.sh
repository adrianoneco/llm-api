apt-get update && apt-get install -y \
    curl \
    ca-certificates \
    uuid-runtime 


curl -fsSL https://lmstudio.ai/install.sh | bash
curl -fsSL https://deb.nodesource.com/setup_22.x | sudo -E bash -
sudo apt-get install -y nodejs
npm install -g npm@11.10.1 pm2 dotenv dotenv-cli bun

npx echo 'y' | lmstudio install-cli
export PATH="/root/.lmstudio/bin:$PATH"
source ~/.bashrc

sudo apt update
sudo apt install libgomp1 -y

lms get qwen/qwen3-4b-2507 (2,50GB)
lms get mistralai/mistral-small-3.2 (15.21 GB)
lms get qwen/qwen3-coder-next (48.49 GB)
lms get mistralai/ministral-3-3b (2.99 GB)
lms get google/functiongemma-270m ( 542.85 MB)
lms get /root/.lmstudio/bin/liquid/lfm2-350m (379.21 MB)