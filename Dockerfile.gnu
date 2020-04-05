FROM debian:stretch-slim

ENV ZOLA_VERSION 0.10.1

RUN apt-get update && apt-get install -y wget git

RUN wget -q -O - \
"https://github.com/getzola/zola/releases/download/v${ZOLA_VERSION}/zola-v${ZOLA_VERSION}-x86_64-unknown-linux-gnu.tar.gz" \
| tar xzf - -C /usr/local/bin

CMD ["zola"]
