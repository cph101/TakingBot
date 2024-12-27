# Multi-stage build to ensure a small final image

# Stage 1: Build the Swift package
FROM swift:6.0 AS build

# Set the working directory
WORKDIR /app

# Copy the package files into the container
COPY Package.swift .
COPY Package.resolved .

COPY Sources ./Sources

# Build the Swift package in release mode
RUN swift build -c release

# Stage 2: Create a lightweight runtime image
FROM swift:slim

# Add user to assert permissions
RUN useradd --user-group --create-home --system --skel /dev/null --home-dir /app taking

# Set the working directory for the runtime container
WORKDIR /app

# Copy the built binary from the builder stage
COPY --from=build --chown=taking:taking /app/.build/release/TakingBot /app/TakingBot

# Run all further commands as taking user
USER taking:taking

# Expose any required port (adjust if needed)
EXPOSE 8080

# Command to run the application
CMD ["./TakingBot"]