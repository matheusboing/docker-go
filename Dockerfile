FROM golang:alpine AS build-stage
WORKDIR /app

RUN go mod init index

COPY . /app

RUN CGO_ENABLED=0 GOOS=linux go build -o api main.go

FROM scratch
WORKDIR /app

COPY --from=build-stage /app/api ./

EXPOSE 8000

CMD ["./api"]

