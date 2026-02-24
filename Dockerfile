FROM ubuntu:24.04

RUN apt-get update && apt-get install -y \
    curl \
    ca-certificates \
    uuid-runtime \
    && rm -rf /var/lib/apt/lists/*

# ensure apt lists are present when installing libgomp
RUN apt-get update && apt-get install -y libgomp1 tcpdump && rm -rf /var/lib/apt/lists/*

RUN curl -fsSL https://lmstudio.ai/install.sh | bash
RUN curl -fsSL https://deb.nodesource.com/setup_22.x | bash -
RUN apt-get install -y nodejs
RUN npm install -g npm@11.10.1 bun dotenv dotenv-cli

RUN echo 'y' | npx lmstudio install-cli
RUN echo 'PATH="/root/.lmstudio/bin:$PATH"' >> /root/.bashrc

RUN apt update

COPY ./api /app
WORKDIR /app
RUN bun install --frozen-lockfile --force

COPY entrypoint.sh /usr/entrypoint.sh
RUN chmod +x /usr/entrypoint.sh

EXPOSE 8443

VOLUME ["/root/.lmstudio"]
ENTRYPOINT ["/usr/entrypoint.sh"]