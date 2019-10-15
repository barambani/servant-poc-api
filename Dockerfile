## Build Dependencies
FROM fpco/stack-build:lts-14.6 as dependencies

RUN mkdir /opt/build

COPY stack.yaml package.yaml stack.yaml.lock /opt/build/

WORKDIR /opt/build
RUN stack build --system-ghc --dependencies-only


## Build Service
FROM fpco/stack-build:lts-14.6 as builder

COPY --from=dependencies /root/.stack /root/.stack
COPY . /opt/build/

WORKDIR /opt/build
RUN stack build --system-ghc
RUN mv "$(stack path --local-install-root --system-ghc)/bin" /opt/build/bin


## Create Production Image
FROM ubuntu:18.04 as service

RUN mkdir -p /opt/servant-poc-api

RUN apt-get update && apt-get install -y \
  ca-certificates \
  libgmp-dev

WORKDIR /opt/servant-poc-api
COPY --from=builder /opt/build/bin .

EXPOSE $PORT
CMD ["/opt/servant-poc-api/servant-poc-api-service"]