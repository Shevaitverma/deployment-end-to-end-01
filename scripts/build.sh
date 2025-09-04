#!/bin/bash

# Build script for the full-stack application
set -e

echo "🚀 Starting build process..."

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Function to print colored output
print_status() {
    echo -e "${GREEN}[INFO]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Check if Docker is running
if ! docker info > /dev/null 2>&1; then
    print_error "Docker is not running. Please start Docker and try again."
    exit 1
fi

# Build backend
print_status "Building backend image..."
docker build -t full-stack-backend:latest ./backend

# Build frontend
print_status "Building frontend image..."
docker build -t full-stack-frontend:latest ./frontend

# Build with docker-compose
print_status "Building with docker-compose..."
docker-compose build

print_status "✅ Build completed successfully!"

# Optional: Run tests
if [ "$1" = "--test" ]; then
    print_status "Running tests..."
    docker-compose up -d
    sleep 10
    
    # Test backend health
    if curl -f http://localhost:4000/health > /dev/null 2>&1; then
        print_status "✅ Backend health check passed"
    else
        print_error "❌ Backend health check failed"
        exit 1
    fi
    
    # Test frontend
    if curl -f http://localhost:3000 > /dev/null 2>&1; then
        print_status "✅ Frontend is accessible"
    else
        print_error "❌ Frontend is not accessible"
        exit 1
    fi
    
    docker-compose down
    print_status "✅ All tests passed!"
fi

print_status "🎉 Build process completed!"
