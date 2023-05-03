FROM golang:1.17 AS builder

RUN mkdir /app
ADD ./test-app/ /app/

RUN cd /app &&  \
    go mod tidy &&  \
    CGO_ENABLED=0 go build -v ./cmd/ops-test-app


FROM alpine:latest

ENV PORT=8080
ENV POSTGRESQL_HOST=localhost
ENV POSTGRESQL_PORT=5432
ENV POSTGRESQL_USER=postgres
ENV POSTGRESQL_DBNAME=postgres

RUN adduser -D -G users gouser
RUN mkdir /app
COPY --from=builder /app/ops-test-app /app/ops-test-app
RUN chown gouser:users /app -R

WORKDIR /app
USER gouser

CMD ["/app/ops-test-app"]

