from debian:stretch-slim

# Set default locale for the environment
ENV LC_ALL C.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US.UTF-8

RUN apt-get update && apt-get install -y wget

RUN wget -q -O - \
"https://github.com/getzola/zola/releases/download/v0.5.0/zola-v0.5.0-x86_64-unknown-linux-gnu.tar.gz" \
| tar xzf - -C /usr/local/bin

ADD entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
