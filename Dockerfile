## Build
FROM fpco/stack-build:lts-14.6 as builder

RUN mkdir /opt/build
COPY . /opt/build

WORKDIR /opt/build

RUN stack build --system-ghc
RUN mv "$(stack path --local-install-root --system-ghc)/bin" /opt/build/bin


## Create
FROM ubuntu:18.04

RUN mkdir -p /opt/servant-poc-api
ARG BINARY_PATH

WORKDIR /opt/servant-poc-api

RUN apt-get update && apt-get install -y \
  ca-certificates \
  libgmp-dev

COPY --from=builder /opt/build/bin .

EXPOSE $PORT
CMD ["/opt/servant-poc-api/servant-poc-api-service"]