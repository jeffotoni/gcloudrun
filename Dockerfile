FROM golang:1.17 as builder
WORKDIR /go/src/gcloudrun.user
COPY . . 

ENV GOPRIVATE=github.com:jeffotoni/gcloudrun.user
ENV GO111MODULE=on

RUN go mod download
RUN CGO_ENABLED=0 go build --trimpath -ldflags="-s -w" -o gcloudrun.user main.go
RUN cp gcloudrun.user /go/bin/gcloudrun.user

FROM alpine:latest as builder2
RUN apk add --no-cache upx

COPY --from=builder /go/bin/gcloudrun.user /go/bin/gcloudrun.user
WORKDIR /go/bin
RUN upx gcloudrun.user
RUN apk del --no-cache upx

FROM scratch
COPY --from=builder2 /go/bin/gcloudrun.user /
EXPOSE 8081
ENTRYPOINT ["/gcloudrun.user"]
