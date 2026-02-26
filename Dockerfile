# syntax=docker/dockerfile:1
# Linux multi-arch Dockerfile for gemini-cli (supports linux/amd64 and linux/arm64)

FROM node:lts-alpine AS base

# Install system dependencies needed for gemini-cli
RUN apk add --no-cache \
    ca-certificates \
    && update-ca-certificates

# Create a non-root user for security
RUN addgroup -S gemini && adduser -S gemini -G gemini

# Install gemini-cli globally
RUN npm install -g gemini-cli \
    && npm cache clean --force

# Switch to non-root user
USER gemini
WORKDIR /home/gemini

# Environment variable for the Gemini API key
ENV GEMINI_API_KEY=""

ENTRYPOINT ["gemini"]
CMD ["--help"]
