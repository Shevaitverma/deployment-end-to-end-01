# Full-Stack Todo Application

A modern full-stack web application built with Next.js, Express.js, MongoDB, and Docker. This project demonstrates a complete end-to-end deployment setup with CI/CD pipeline.

## 🚀 Live Demo

- **Frontend**: http://localhost:3000
- **Backend API**: http://localhost:4000
- **Health Check**: http://localhost:4000/health

## 📋 Table of Contents

- [Features](#features)
- [Tech Stack](#tech-stack)
- [Prerequisites](#prerequisites)
- [Project Structure](#project-structure)
- [Quick Start](#quick-start)
- [Development Setup](#development-setup)
- [Docker Setup](#docker-setup)
- [Environment Configuration](#environment-configuration)
- [API Documentation](#api-documentation)
- [CI/CD Pipeline](#cicd-pipeline)
- [Deployment](#deployment)
- [Troubleshooting](#troubleshooting)
- [Contributing](#contributing)

## ✨ Features

- **Todo Management**: Create, read, update, and delete todos
- **Real-time Updates**: Instant UI updates after operations
- **Responsive Design**: Works on desktop and mobile devices
- **Docker Support**: Containerized for easy deployment
- **CI/CD Pipeline**: Automated testing and deployment
- **Health Monitoring**: Built-in health check endpoints
- **CORS Enabled**: Secure cross-origin requests
- **TypeScript**: Type-safe frontend development

## 🛠️ Tech Stack

### Frontend
- **Next.js 15.5.2** - React framework
- **React 19.1.0** - UI library
- **TypeScript** - Type safety
- **Tailwind CSS** - Styling
- **ESLint** - Code linting

### Backend
- **Node.js 20** - Runtime environment
- **Express.js 5.1.0** - Web framework
- **MongoDB** - Database
- **Mongoose 8.18.0** - ODM
- **CORS** - Cross-origin resource sharing

### DevOps
- **Docker** - Containerization
- **Docker Compose** - Multi-container orchestration
- **GitHub Actions** - CI/CD pipeline
- **Nginx** - Reverse proxy (production)

## 📋 Prerequisites

Before running this project, make sure you have the following installed:

### Required Software
- **Node.js** (v20 or higher) - [Download](https://nodejs.org/)
- **npm** (comes with Node.js)
- **Docker** - [Download](https://www.docker.com/get-started)
- **Docker Compose** - [Download](https://docs.docker.com/compose/install/)
- **Git** - [Download](https://git-scm.com/)

### Required Accounts
- **MongoDB Atlas** account (free) - [Sign up](https://www.mongodb.com/atlas)
- **GitHub** account (for CI/CD)

### System Requirements
- **RAM**: Minimum 4GB (8GB recommended)
- **Storage**: 2GB free space
- **OS**: Windows 10+, macOS 10.15+, or Linux

## 📁 Project Structure

```
full-end-to-end-deployment/
├── .github/
│   └── workflows/
│       └── ci-cd.yml          # GitHub Actions CI/CD pipeline
├── backend/
│   ├── Dockerfile             # Backend container configuration
│   ├── .dockerignore          # Docker ignore file
│   ├── package.json           # Backend dependencies
│   ├── package-lock.json      # Dependency lock file
│   └── index.js               # Backend server code
├── frontend/
│   ├── Dockerfile             # Frontend container configuration
│   ├── .dockerignore          # Docker ignore file
│   ├── package.json           # Frontend dependencies
│   ├── package-lock.json      # Dependency lock file
│   ├── next.config.ts         # Next.js configuration
│   ├── tsconfig.json          # TypeScript configuration
│   ├── tailwind.config.js     # Tailwind CSS configuration
│   └── src/
│       └── app/
│           ├── layout.tsx      # App layout
│           ├── page.tsx        # Main page component
│           └── globals.css     # Global styles
├── scripts/
│   ├── build.sh               # Build script
│   └── deploy.sh              # Deployment script
├── docker-compose.yml         # Development Docker setup
├── docker-compose.prod.yml    # Production Docker setup
├── nginx.conf                 # Nginx configuration
├── env.example                # Environment variables template
├── DEPLOYMENT.md              # Detailed deployment guide
└── README.md                  # This file
```

## 🚀 Quick Start

### Option 1: Docker (Recommended)

1. **Clone the repository**
   ```bash
   git clone <your-repo-url>
   cd full-end-to-end-deployment
   ```

2. **Set up environment variables**
   ```bash
   cp env.example .env
   # Edit .env with your MongoDB URI
   ```

3. **Start the application**
   ```bash
   docker-compose up --build
   ```

4. **Access the application**
   - Frontend: http://localhost:3000
   - Backend: http://localhost:4000

### Option 2: Local Development

1. **Clone and setup**
   ```bash
   git clone <your-repo-url>
   cd full-end-to-end-deployment
   ```

2. **Backend setup**
   ```bash
   cd backend
   npm install
   npm run dev
   ```

3. **Frontend setup** (in a new terminal)
   ```bash
   cd frontend
   npm install
   npm run dev
   ```

## 🔧 Development Setup

### Backend Development

1. **Navigate to backend directory**
   ```bash
   cd backend
   ```

2. **Install dependencies**
   ```bash
   npm install
   ```

3. **Set up environment variables**
   ```bash
   # Create .env file in backend directory
   echo "PORT=4000" > .env
   echo "MONGODB_URI=your_mongodb_uri_here" >> .env
   echo "CORS_ORIGIN=http://localhost:3000" >> .env
   ```

4. **Start development server**
   ```bash
   npm run dev
   ```

### Frontend Development

1. **Navigate to frontend directory**
   ```bash
   cd frontend
   ```

2. **Install dependencies**
   ```bash
   npm install
   ```

3. **Set up environment variables**
   ```bash
   # Create .env.local file in frontend directory
   echo "NEXT_PUBLIC_API_URL=http://localhost:4000" > .env.local
   ```

4. **Start development server**
   ```bash
   npm run dev
   ```

## 🐳 Docker Setup

### Development with Docker

```bash
# Build and start all services
docker-compose up --build

# Run in background
docker-compose up -d --build

# View logs
docker-compose logs -f

# Stop services
docker-compose down
```

### Production with Docker

```bash
# Use production configuration
docker-compose -f docker-compose.prod.yml up -d

# With custom environment file
docker-compose -f docker-compose.prod.yml --env-file .env.prod up -d
```

### Individual Container Commands

```bash
# Build backend only
docker build -t backend ./backend

# Build frontend only
docker build -t frontend ./frontend

# Run backend container
docker run -p 4000:4000 -e MONGODB_URI=your_uri backend

# Run frontend container
docker run -p 3000:3000 -e NEXT_PUBLIC_API_URL=http://localhost:4000 frontend
```

## ⚙️ Environment Configuration

### Required Environment Variables

Create a `.env` file in the root directory:

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

1. **Create MongoDB Atlas account**
   - Go to [MongoDB Atlas](https://www.mongodb.com/atlas)
   - Sign up for free account

2. **Create a cluster**
   - Choose free tier (M0)
   - Select your preferred region

3. **Set up database access**
   - Create database user
   - Set username and password

4. **Configure network access**
   - Add IP address (0.0.0.0/0 for development)
   - Or add your specific IP

5. **Get connection string**
   - Click "Connect" on your cluster
   - Choose "Connect your application"
   - Copy the connection string
   - Replace `<password>` with your database user password

## 📚 API Documentation

### Base URL
```
http://localhost:4000
```

### Endpoints

#### Health Check
```http
GET /health
```
**Response:**
```json
{
  "ok": true
}
```

#### Get All Todos
```http
GET /api/todos
```
**Response:**
```json
[
  {
    "_id": "64f1a2b3c4d5e6f7g8h9i0j1",
    "title": "Learn Docker",
    "completed": false,
    "createdAt": "2023-09-01T10:00:00.000Z",
    "updatedAt": "2023-09-01T10:00:00.000Z"
  }
]
```

#### Create Todo
```http
POST /api/todos
Content-Type: application/json

{
  "title": "New todo item"
}
```
**Response:**
```json
{
  "_id": "64f1a2b3c4d5e6f7g8h9i0j2",
  "title": "New todo item",
  "completed": false,
  "createdAt": "2023-09-01T10:05:00.000Z",
  "updatedAt": "2023-09-01T10:05:00.000Z"
}
```

#### Update Todo
```http
PATCH /api/todos/:id
Content-Type: application/json

{
  "title": "Updated title",
  "completed": true
}
```
**Response:**
```json
{
  "_id": "64f1a2b3c4d5e6f7g8h9i0j1",
  "title": "Updated title",
  "completed": true,
  "createdAt": "2023-09-01T10:00:00.000Z",
  "updatedAt": "2023-09-01T10:05:00.000Z"
}
```

#### Delete Todo
```http
DELETE /api/todos/:id
```
**Response:**
```
204 No Content
```

## 🔄 CI/CD Pipeline

### GitHub Actions Workflow

The project includes a basic CI/CD pipeline that:

1. **Triggers** on pushes to `main` branch
2. **Installs** Node.js dependencies
3. **Builds** the frontend application
4. **Creates** Docker images
5. **Tests** containers by starting them and checking health endpoints

### Pipeline Steps

```yaml
name: Basic CI/CD

on:
  push:
    branches: [ main ]

jobs:
  build:
    runs-on: ubuntu-latest
    
    steps:
    - Checkout code
    - Setup Node.js 20
    - Install backend dependencies
    - Install frontend dependencies
    - Build frontend
    - Build Docker images
    - Test Docker containers
```

### Setting up CI/CD

1. **Push your code to GitHub**
2. **Go to Actions tab** in your repository
3. **Enable GitHub Actions** if prompted
4. **Push to main branch** to trigger the pipeline

## 🚀 Deployment

### Local Production Deployment

```bash
# Use production Docker Compose
docker-compose -f docker-compose.prod.yml up -d

# Check status
docker-compose -f docker-compose.prod.yml ps

# View logs
docker-compose -f docker-compose.prod.yml logs -f
```

### Cloud Deployment Options

#### AWS ECS
```bash
# Build and push to ECR
aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin <account>.dkr.ecr.us-east-1.amazonaws.com
docker tag backend:latest <account>.dkr.ecr.us-east-1.amazonaws.com/backend:latest
docker push <account>.dkr.ecr.us-east-1.amazonaws.com/backend:latest
```

#### Google Cloud Run
```bash
# Build and deploy
gcloud builds submit --tag gcr.io/PROJECT-ID/full-stack-app
gcloud run deploy --image gcr.io/PROJECT-ID/full-stack-app --platform managed
```

#### DigitalOcean App Platform
1. Connect your GitHub repository
2. Configure build settings
3. Set environment variables
4. Deploy automatically

### Using Deployment Scripts

```bash
# Make scripts executable (Linux/Mac)
chmod +x scripts/*.sh

# Build with tests
./scripts/build.sh --test

# Deploy to production
./scripts/deploy.sh
```

## 🔍 Troubleshooting

### Common Issues

#### 1. Port Already in Use
```bash
# Check what's using the port
netstat -tulpn | grep :3000
netstat -tulpn | grep :4000

# Kill process using port
sudo kill -9 <PID>
```

#### 2. Docker Build Fails
```bash
# Clean Docker cache
docker system prune -a

# Rebuild without cache
docker-compose build --no-cache
```

#### 3. Database Connection Issues
- Verify MongoDB URI is correct
- Check network connectivity
- Ensure database user has proper permissions
- Verify IP whitelist in MongoDB Atlas

#### 4. CORS Errors
- Check CORS_ORIGIN matches your frontend URL
- Verify frontend is making requests to correct backend URL
- Ensure backend is running on correct port

#### 5. Frontend Can't Connect to Backend
- Check NEXT_PUBLIC_API_URL environment variable
- Verify backend is running and accessible
- Check Docker network configuration

### Debug Commands

```bash
# Check container status
docker-compose ps

# View container logs
docker-compose logs backend
docker-compose logs frontend

# Access container shell
docker-compose exec backend sh
docker-compose exec frontend sh

# Check environment variables
docker-compose exec backend env
docker-compose exec frontend env

# Test API endpoints
curl http://localhost:4000/health
curl http://localhost:4000/api/todos
```

### Health Checks

```bash
# Backend health
curl -f http://localhost:4000/health

# Frontend accessibility
curl -f http://localhost:3000

# Database connection (from backend container)
docker-compose exec backend node -e "console.log('Testing DB connection...')"
```

## 🤝 Contributing

### Development Workflow

1. **Fork the repository**
2. **Create a feature branch**
   ```bash
   git checkout -b feature/your-feature-name
   ```
3. **Make your changes**
4. **Test your changes**
   ```bash
   docker-compose up --build
   ```
5. **Commit your changes**
   ```bash
   git commit -m "Add your feature"
   ```
6. **Push to your fork**
   ```bash
   git push origin feature/your-feature-name
   ```
7. **Create a Pull Request**

### Code Style

- Use TypeScript for frontend code
- Follow ESLint configuration
- Use meaningful commit messages
- Add comments for complex logic
- Test your changes before submitting

### Testing

```bash
# Run frontend tests
cd frontend && npm test

# Run backend tests
cd backend && npm test

# Test Docker setup
docker-compose up --build
```

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🙏 Acknowledgments

- [Next.js](https://nextjs.org/) - React framework
- [Express.js](https://expressjs.com/) - Web framework
- [MongoDB](https://www.mongodb.com/) - Database
- [Docker](https://www.docker.com/) - Containerization
- [Tailwind CSS](https://tailwindcss.com/) - CSS framework

## 📞 Support

If you encounter any issues or have questions:

1. Check the [Troubleshooting](#troubleshooting) section
2. Search existing [GitHub Issues](https://github.com/your-username/your-repo/issues)
3. Create a new issue with detailed information
4. Contact the maintainers

---

**Happy Coding! 🚀**
