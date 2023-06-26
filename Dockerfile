# Container image that runs your code
FROM golang:1.20.0-alpine3.14

RUN mkdir /app

COPY go.mod /app

RUN cd /app && go mod download

COPY main.go /app

RUN CGO_ENABLED=0 GOOS=linux go build -o /app/bruh /app/main.go

ENTRYPOINT [ "/app/bruh" ]