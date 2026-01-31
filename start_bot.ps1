$env:GEMINI_API_KEY = "AIzaSyCnmerxwYYt0vHPM6BWhxGljS2NRhzPpOM"
$env:NODE_OPTIONS = "--max-old-space-size=2048"

Write-Host "Starting Moltbot WhatsApp Gateway..." -ForegroundColor Cyan
Write-Host "Watch for QR code to scan with WhatsApp..." -ForegroundColor Yellow
Write-Host ""

& "node_modules\.bin\clawdbot" gateway 2>&1 | Tee-Object -FilePath "bot_output.log"
