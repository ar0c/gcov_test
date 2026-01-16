FROM golang:1.24-alpine AS build

ENV GOARCH=amd64 \
    CGO_ENABLED=0 \
    GOPROXY=https://goproxy.cn,direct

WORKDIR /go/src
RUN apk add --no-cache curl tar
RUN curl -L "https://github.com/ar0c/goc/releases/download/v2.1.4/goc-v2.1.4-linux-amd64.tar.gz" | tar -xz -C /usr/local/bin/

COPY go.mod go.sum ./
RUN go mod download

COPY . .
ARG GOC_SERVER_ADDR
RUN goc build -o /go/bin/main . --gochost ${GOC_SERVER_ADDR}

FROM alpine:3

WORKDIR /go/bin

COPY --chown=0:0 --from=build /go/bin /go/bin
