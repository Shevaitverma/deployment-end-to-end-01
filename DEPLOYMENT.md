# Deployment Guide

This guide covers how to deploy your full-stack application using Docker and CI/CD.

## 🚀 Quick Start

### Local Development
```bash
# Clone the repository
git clone <your-repo-url>
cd full-end-to-end-deployment

# Copy environment file
cp env.example .env
# Edit .env with your actual values

# Start the application
docker-compose up --build
```

### Production Deployment
```bash
# Use production compose file
docker-compose -f docker-compose.prod.yml up -d
```

## 📋 Prerequisites

- Docker and Docker Compose installed
- Git repository with your code
- MongoDB Atlas account (or local MongoDB)
- GitHub account (for CI/CD)

## 🔧 Environment Configuration

### Required Environment Variables

Create a `.env` file based on `env.example`:

```bash
# Backend Configuration
PORT=4000
NODE_ENV=production

# Database Configuration
MONGODB_URI=mongodb+srv://username:password@cluster.mongodb.net/database_name

# CORS Configuration
CORS_ORIGIN=http://localhost:3000

# Frontend Configuration
NEXT_PUBLIC_API_URL=http://localhost:4000
```

### MongoDB Setup

1. Create a MongoDB Atlas account
2. Create a new cluster
3. Get your connection string
4. Update `MONGODB_URI` in your `.env` file

## 🐳 Docker Commands

### Build and Run
```bash
# Build all services
docker-compose build

# Start services
docker-compose up -d

# View logs
docker-compose logs -f

# Stop services
docker-compose down
```

### Using Build Scripts
```bash
# Build with tests
./scripts/build.sh --test

# Deploy to production
./scripts/deploy.sh

# Deploy with latest images
./scripts/deploy.sh --pull
```

## 🔄 CI/CD Pipeline

The GitHub Actions workflow automatically:

1. **Tests**: Runs tests on pull requests
2. **Builds**: Creates Docker images on main branch pushes
3. **Security**: Scans for vulnerabilities
4. **Deploys**: Pushes images to GitHub Container Registry

### Setting up CI/CD

1. **Push your code to GitHub**
2. **Enable GitHub Actions** in your repository settings
3. **Set up secrets** (if needed for deployment):
   - Go to Settings → Secrets and variables → Actions
   - Add any required secrets

### Workflow Triggers

- **Pull Requests**: Runs tests and security scans
- **Main Branch**: Full CI/CD pipeline including deployment

## 🌐 Production Deployment Options

### Option 1: Docker Compose (Simple)
```bash
# Use production configuration
docker-compose -f docker-compose.prod.yml up -d
```

### Option 2: Cloud Providers

#### AWS ECS
```bash
# Build and push to ECR
aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin <account>.dkr.ecr.us-east-1.amazonaws.com
docker tag full-stack-backend:latest <account>.dkr.ecr.us-east-1.amazonaws.com/full-stack-backend:latest
docker push <account>.dkr.ecr.us-east-1.amazonaws.com/full-stack-backend:latest
```

#### Google Cloud Run
```bash
# Build and deploy
gcloud builds submit --tag gcr.io/PROJECT-ID/full-stack-app
gcloud run deploy --image gcr.io/PROJECT-ID/full-stack-app --platform managed
```

#### Azure Container Instances
```bash
# Build and push to ACR
az acr build --registry <registry-name> --image full-stack-app .
```

### Option 3: Kubernetes

Create Kubernetes manifests for production deployment:

```yaml
# k8s/backend-deployment.yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: backend
spec:
  replicas: 3
  selector:
    matchLabels:
      app: backend
  template:
    metadata:
      labels:
        app: backend
    spec:
      containers:
      - name: backend
        image: ghcr.io/your-username/full-stack-backend:latest
        ports:
        - containerPort: 4000
        env:
        - name: MONGODB_URI
          valueFrom:
            secretKeyRef:
              name: mongodb-secret
              key: uri
```

## 🔍 Monitoring and Health Checks

### Health Check Endpoints
- **Backend**: `http://localhost:4000/health`
- **Frontend**: `http://localhost:3000`

### Monitoring Commands
```bash
# Check container status
docker-compose ps

# View logs
docker-compose logs backend
docker-compose logs frontend

# Check resource usage
docker stats
```

## 🛠️ Troubleshooting

### Common Issues

1. **Port conflicts**
   ```bash
   # Check what's using the ports
   netstat -tulpn | grep :3000
   netstat -tulpn | grep :4000
   ```

2. **Database connection issues**
   - Verify MongoDB URI is correct
   - Check network connectivity
   - Ensure database user has proper permissions

3. **CORS errors**
   - Verify CORS_ORIGIN matches your frontend URL
   - Check if frontend is making requests to correct backend URL

4. **Build failures**
   ```bash
   # Clean Docker cache
   docker system prune -a
   
   # Rebuild without cache
   docker-compose build --no-cache
   ```

### Debug Mode
```bash
# Run with debug logs
DEBUG=* docker-compose up

# Access container shell
docker-compose exec backend sh
docker-compose exec frontend sh
```

## 📊 Performance Optimization

### Production Optimizations

1. **Use multi-stage builds** (already implemented)
2. **Enable gzip compression**
3. **Use CDN for static assets**
4. **Implement caching strategies**
5. **Monitor resource usage**

### Scaling
```bash
# Scale backend service
docker-compose up -d --scale backend=3

# Use load balancer
docker-compose -f docker-compose.prod.yml up -d
```

## 🔒 Security Considerations

1. **Environment Variables**: Never commit `.env` files
2. **Secrets Management**: Use proper secrets management in production
3. **Image Scanning**: Regularly scan Docker images for vulnerabilities
4. **Network Security**: Use proper firewall rules
5. **SSL/TLS**: Enable HTTPS in production

## 📚 Additional Resources

- [Docker Documentation](https://docs.docker.com/)
- [Docker Compose Documentation](https://docs.docker.com/compose/)
- [GitHub Actions Documentation](https://docs.github.com/en/actions)
- [MongoDB Atlas Documentation](https://docs.atlas.mongodb.com/)
