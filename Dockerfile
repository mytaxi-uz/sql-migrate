ARG GO_VERSION=1.25-alpine
ARG ALPINE_VERSION=3.23

### Vendor
FROM golang:${GO_VERSION} as builder
RUN apk add --no-cache git gcc g++
RUN go install github.com/rubenv/sql-migrate/...@v1.8.1

### Image
FROM alpine:${ALPINE_VERSION} as image
RUN apk add --no-cache curl make
COPY --from=builder /go/bin/sql-migrate /bin/sql-migrate
