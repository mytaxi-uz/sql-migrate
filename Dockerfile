ARG GO_VERSION=1.19-alpine
ARG ALPINE_VERSION=3.18

### Vendor
FROM golang:${GO_VERSION} as builder
RUN apk add --no-cache git gcc g++
RUN go install github.com/rubenv/sql-migrate/...@v1.5.2

### Image
FROM alpine:${ALPINE_VERSION} as image
RUN apk add --no-cache curl make
COPY --from=builder /go/bin/sql-migrate /bin/sql-migrate
