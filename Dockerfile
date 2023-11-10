# syntax=docker/dockerfile:1

FROM golang:1.21 as build
WORKDIR /app
COPY catgpt/ .
RUN CGO_ENABLED=0 go build -o catgpt

FROM gcr.io/distroless/static-debian12:latest-amd64
WORKDIR /
COPY --from=build /app/catgpt .
EXPOSE 8080
ENTRYPOINT ["/catgpt"]
