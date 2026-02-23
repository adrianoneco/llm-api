FROM ubuntu:22.04

RUN apt-get update && apt-get install -y \
    curl \
    ca-certificates \
    && rm -rf /var/lib/apt/lists/*

# ensure apt lists are present when installing libgomp
RUN apt-get update && apt-get install -y libgomp1 tcpdump && rm -rf /var/lib/apt/lists/*

RUN curl -fsSL https://lmstudio.ai/install.sh | bash
RUN curl -fsSL https://deb.nodesource.com/setup_22.x | bash -
RUN apt-get install -y nodejs
RUN npm install -g npm@11.10.1

RUN npx lmstudio install-cli --yes
ENV PATH="/root/.lmstudio/bin:$PATH"

RUN apt update

COPY entrypoint.sh /usr/entrypoint.sh
RUN chmod +x /usr/entrypoint.sh

EXPOSE 8443
ENTRYPOINT ["/usr/entrypoint.sh"]

CMD ["tcpdump", "-i", "any", "-nn", "-X", "port", "8443"]