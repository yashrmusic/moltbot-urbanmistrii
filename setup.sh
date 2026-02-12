#!/bin/bash
# Quick setup script for DigitalOcean deployment
# Run this on your local machine before deploying

set -e

echo "🚀 URBANMISTRII Content Bot - Setup Script"
echo "==========================================="
echo ""

# Check prerequisites
echo "📋 Checking prerequisites..."
if ! command -v git &> /dev/null; then
    echo "❌ Git is required but not installed"
    exit 1
fi
echo "✓ Git installed"

if ! command -v node &> /dev/null; then
    echo "❌ Node.js is required but not installed"
    exit 1
fi
echo "✓ Node.js installed: $(node -v)"

if ! command -v npm &> /dev/null; then
    echo "❌ npm is required but not installed"
    exit 1
fi
echo "✓ npm installed: $(npm -v)"

echo ""
echo "📦 Installing dependencies..."
npm install

echo ""
echo "🔧 Setting up environment..."
if [ ! -f .env ]; then
    cp .env.example .env
    echo "✓ Created .env file"
    echo "⚠️  Please edit .env with your API keys before deploying"
else
    echo "✓ .env file already exists"
fi

echo ""
echo "🐳 Docker setup..."
if command -v docker &> /dev/null; then
    echo "✓ Docker installed: $(docker --version)"
    echo ""
    echo "You can test locally with:"
    echo "  docker-compose up -d"
    echo "  docker-compose logs -f"
else
    echo "⚠️  Docker not installed (optional for local testing)"
fi

echo ""
echo "✅ Setup complete!"
echo ""
echo "🎯 Next steps:"
echo "1. Edit .env with your API keys"
echo "2. Run: npm start (local testing)"
echo "3. Or deploy to DigitalOcean:"
echo "   - Option 1: App Platform (Free) - Follow DIGITALOCEAN_DEPLOYMENT.md"
echo "   - Option 2: Droplet ($6/mo) - Follow DIGITALOCEAN_DEPLOYMENT.md"
echo ""
echo "📖 Read full guide: DIGITALOCEAN_DEPLOYMENT.md"
