FROM golang:1.24 AS build

ENV GOARCH=amd64 \
    CGO_ENABLED=0 \
    GOPROXY=https://goproxy.cn,direct

WORKDIR /go/src

COPY go.mod go.sum .
COPY goc .
RUN chmod +x goc && \
    mv goc /usr/local/bin && \
    echo "goc version" $(goc version)

RUN go mod download

COPY . .
ARG GOC_SERVER_ADDR
RUN goc build -o /go/bin/main . --gochost ${GOC_SERVER_ADDR}

FROM alpine:3

WORKDIR /go/bin

COPY --chown=0:0 --from=build /go/bin /go/bin
