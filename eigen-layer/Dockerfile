# Stage 1: Build the Eigenlayer CLI
FROM --platform=linux/amd64 docker.io/golang:1.23-alpine as builder

# Install required dependencies for Alpine
RUN apk add --no-cache \
    bash \
    curl \
    git \
    gcc \
    libc-dev \
    make \
    openssl-dev \
    sudo

# Set up Go environment
ENV GOPATH=/go
ENV PATH=$GOPATH/bin:/usr/local/go/bin:$PATH

RUN go install github.com/Layr-Labs/eigenlayer-cli/cmd/eigenlayer@latest



# Stage 2: Create the final runtime image
FROM --platform=linux/amd64 ghcr.io/layr-labs/eigenda/opr-node:0.7.4

# Copy the Eigenlayer CLI binary from the builder stage
COPY --from=builder /go/bin/eigenlayer /usr/local/bin/eigenlayer

# Install required dependencies for runtime
RUN apk add --no-cache \
    bash \
    curl \
    openssl-dev

# Set the entrypoint
ENTRYPOINT ["node"]
