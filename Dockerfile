ARG GO_VERSION=1.24-alpine
ARG ALPINE_VERSION=3.18
ARG SQL_MIGRATE_VERSION=v1.8.1

### Vendor
FROM golang:${GO_VERSION} as builder
RUN apk add --no-cache git gcc g++
RUN go install github.com/rubenv/sql-migrate/...@${SQL_MIGRATE_VERSION}

### Image
FROM alpine:${ALPINE_VERSION} as image
RUN apk add --no-cache curl make
COPY --from=builder /go/bin/sql-migrate /bin/sql-migrate
