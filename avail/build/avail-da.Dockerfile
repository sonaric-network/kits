# Stage 1: Build avail-da binary
FROM golang:1.19 as builder

# Set the working directory inside the container
WORKDIR /app

# Install git to clone the repository
RUN apt-get update && apt-get install -y git

# Clone the rollkit/avail-da repository
RUN git clone https://github.com/rollkit/avail-da.git

# Navigate to the avail-da directory
WORKDIR /app/avail-da

# Build the binary
RUN go mod tidy && go build -o avail-da

# Stage 2: Create a minimal image to run avail-da
FROM alpine:3.17

# Set the working directory
WORKDIR /app

# Copy the binary from the builder stage
COPY --from=builder /app/avail-da/avail-da .

# Allow environment variable to configure the light node URL
ENV LIGHT_NODE_URL=http://localhost:26657

# Expose any required ports (this example uses port 26657)
EXPOSE 26657

# Start the avail-da binary with the light node URL as a flag
ENTRYPOINT ["/app/avail-da"]
CMD ["--light-node", "$LIGHT_NODE_URL"]
