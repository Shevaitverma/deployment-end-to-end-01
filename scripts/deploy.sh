#!/bin/bash

# Deployment script for the full-stack application
set -e

echo "🚀 Starting deployment process..."

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

# Check if environment file exists
if [ ! -f .env ]; then
    print_warning ".env file not found. Creating from .env.example..."
    if [ -f .env.example ]; then
        cp .env.example .env
        print_warning "Please update .env file with your actual values before deploying!"
    else
        print_error ".env.example file not found. Please create environment configuration."
        exit 1
    fi
fi

# Load environment variables
source .env

# Check required environment variables
required_vars=("MONGODB_URI" "CORS_ORIGIN")
for var in "${required_vars[@]}"; do
    if [ -z "${!var}" ]; then
        print_error "Required environment variable $var is not set"
        exit 1
    fi
done

# Stop existing containers
print_status "Stopping existing containers..."
docker-compose down || true

# Pull latest images (if using registry)
if [ "$1" = "--pull" ]; then
    print_status "Pulling latest images..."
    docker-compose pull
fi

# Build and start services
print_status "Building and starting services..."
docker-compose up -d --build

# Wait for services to be ready
print_status "Waiting for services to be ready..."
sleep 15

# Health checks
print_status "Performing health checks..."

# Check backend
max_attempts=30
attempt=1
while [ $attempt -le $max_attempts ]; do
    if curl -f http://localhost:4000/health > /dev/null 2>&1; then
        print_status "✅ Backend is healthy"
        break
    fi
    
    if [ $attempt -eq $max_attempts ]; then
        print_error "❌ Backend health check failed after $max_attempts attempts"
        docker-compose logs backend
        exit 1
    fi
    
    print_status "Backend not ready yet, attempt $attempt/$max_attempts..."
    sleep 2
    ((attempt++))
done

# Check frontend
attempt=1
while [ $attempt -le $max_attempts ]; do
    if curl -f http://localhost:3000 > /dev/null 2>&1; then
        print_status "✅ Frontend is accessible"
        break
    fi
    
    if [ $attempt -eq $max_attempts ]; then
        print_error "❌ Frontend health check failed after $max_attempts attempts"
        docker-compose logs frontend
        exit 1
    fi
    
    print_status "Frontend not ready yet, attempt $attempt/$max_attempts..."
    sleep 2
    ((attempt++))
done

print_status "🎉 Deployment completed successfully!"
print_status "Frontend: http://localhost:3000"
print_status "Backend API: http://localhost:4000"
print_status "Backend Health: http://localhost:4000/health"

# Show running containers
print_status "Running containers:"
docker-compose ps
