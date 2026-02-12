# Quick setup script for DigitalOcean deployment
# Run this on Windows before deploying
# Usage: .\setup.ps1

Write-Host "🚀 URBANMISTRII Content Bot - Setup Script (Windows)" -ForegroundColor Cyan
Write-Host "=====================================================`n" -ForegroundColor Cyan

# Check prerequisites
Write-Host "📋 Checking prerequisites..." -ForegroundColor Yellow

if (-not (Get-Command git -ErrorAction SilentlyContinue)) {
    Write-Host "❌ Git is required but not installed" -ForegroundColor Red
    exit 1
}
Write-Host "✓ Git installed" -ForegroundColor Green

if (-not (Get-Command node -ErrorAction SilentlyContinue)) {
    Write-Host "❌ Node.js is required but not installed" -ForegroundColor Red
    exit 1
}
$nodeVersion = & node --version
Write-Host "✓ Node.js installed: $nodeVersion" -ForegroundColor Green

if (-not (Get-Command npm -ErrorAction SilentlyContinue)) {
    Write-Host "❌ npm is required but not installed" -ForegroundColor Red
    exit 1
}
$npmVersion = & npm --version
Write-Host "✓ npm installed: $npmVersion" -ForegroundColor Green

Write-Host "`n📦 Installing dependencies..." -ForegroundColor Yellow
npm install

Write-Host "`n🔧 Setting up environment..." -ForegroundColor Yellow
if (-not (Test-Path .env)) {
    Copy-Item .env.example .env
    Write-Host "✓ Created .env file" -ForegroundColor Green
    Write-Host "⚠️  Please edit .env with your API keys before deploying" -ForegroundColor Yellow
} else {
    Write-Host "✓ .env file already exists" -ForegroundColor Green
}

Write-Host "`n🐳 Docker setup..." -ForegroundColor Yellow
if (Get-Command docker -ErrorAction SilentlyContinue) {
    $dockerVersion = & docker --version
    Write-Host "✓ Docker installed: $dockerVersion" -ForegroundColor Green
    Write-Host "`nYou can test locally with:" -ForegroundColor Cyan
    Write-Host "  docker-compose up -d" -ForegroundColor White
    Write-Host "  docker-compose logs -f" -ForegroundColor White
} else {
    Write-Host "⚠️  Docker not installed (optional for local testing)" -ForegroundColor Yellow
}

Write-Host "`n✅ Setup complete!" -ForegroundColor Green
Write-Host "`n🎯 Next steps:" -ForegroundColor Cyan
Write-Host "1. Edit .env with your API keys" -ForegroundColor White
Write-Host "2. Run: npm start (local testing)" -ForegroundColor White
Write-Host "3. Or deploy to DigitalOcean:" -ForegroundColor White
Write-Host "   - Option 1: App Platform (Free) - Follow DIGITALOCEAN_DEPLOYMENT.md" -ForegroundColor White
Write-Host "   - Option 2: Droplet (\$6/mo) - Follow DIGITALOCEAN_DEPLOYMENT.md" -ForegroundColor White
Write-Host "`n📖 Read full guide: DIGITALOCEAN_DEPLOYMENT.md" -ForegroundColor Yellow
