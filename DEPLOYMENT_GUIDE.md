# 🏛️ URBANMISTRII Bot - Deployment Guide

## 📋 Project Overview

**Project Name:** `urbanmistrii-content-bot`  
**Purpose:** Headless Content Director AI for URBANMISTRII  
**Framework:** Clawdbot (WhatsApp-enabled AI agent)

---

## 🤖 Bot Instances & Deployment Options

This project supports **THREE** deployment modes:

### 1. 🖥️ **Local Development (Windows/Mac/Linux)**
- **Location:** Your local machine
- **Purpose:** Testing, development, and immediate interaction
- **Start Command:** `.\start_bot.ps1` (Windows) or `npm start` (Linux/Mac)
- **Pros:** 
  - Instant testing
  - Full console access
  - Easy debugging
- **Cons:** 
  - Requires your computer to stay on
  - Not suitable for 24/7 operation

### 2. ☁️ **AWS EC2 Deployment**
- **Location:** AWS EC2 (t2.micro)
- **IP:** `54.174.12.251`
- **User:** `ec2-user`
- **Key:** `moltbot-key.pem`
- **OS:** Amazon Linux 2
- **Start Command:** `pm2 start npm --name "moltbot" -- start`
- **Pros:**
  - Full control over infrastructure
  - Can scale resources (disk, RAM, CPU)
  - Cost-effective for long-term use
- **Cons:**
  - Requires manual setup and maintenance
  - Need to manage security updates
  - Currently has disk space limitations (8GB → needs 30GB)

### 3. 🚀 **Zeabur Deployment**
- **Location:** Zeabur cloud platform
- **Purpose:** Containerized deployment (uses Dockerfile)
- **Start Command:** Automatic via `Dockerfile`
- **Pros:**
  - Zero-maintenance deployment
  - Automatic scaling
  - Built-in monitoring
  - Easy rollbacks
- **Cons:**
  - Less control over infrastructure
  - Potential cost for higher usage

---

## 🔑 Current Configuration

### API Keys & Credentials
```bash
GEMINI_API_KEY=AIzaSyCnmerxwYYt0vHPM6BWhxGljS2NRhzPpOM
EMAIL_PASS_MAIL=Rr22081993!
EMAIL_PASS_HR=Rr22081993!
```

### WhatsApp Configuration
- **Allowed Number:** +919312943581
- **Self-Chat Mode:** Enabled
- **DM Policy:** Allowlist only

### Skills & Integrations
1. **Email Management** (`urbanmistrii_mail.py`)
   - Monitors: `mail@urbanmistrii.com`, `hr@urbanmistrii.com`
   - IMAP/SMTP via Gmail

2. **Instagram Publisher** (`urbanmistrii_instagram.py`)
   - Requires: `IG_USER_ID`, `IG_ACCESS_TOKEN`
   - API: Facebook Graph API v21.0

3. **Google Drive Integration** (`UrbanMistriiDrive.js`)
   - Document management and sharing

---

## 🚀 Quick Start Guide

### Option A: Local Testing (Recommended for Now)

1. **Install Dependencies:**
   ```bash
   npm install --omit=dev
   pip install -r requirements.txt
   ```

2. **Start the Bot:**
   ```powershell
   # Windows
   .\start_bot.ps1
   
   # Linux/Mac
   npm start
   ```

3. **Scan QR Code:**
   - Watch the console for a QR code
   - Open WhatsApp on your phone
   - Go to Settings → Linked Devices → Link a Device
   - Scan the QR code

4. **Test the Bot:**
   - Send a message to the linked WhatsApp number
   - The bot should respond via Gemini AI

### Option B: AWS EC2 Deployment

**Prerequisites:**
- SSH key: `moltbot-key.pem`
- AWS Console access

**Steps:**

1. **Expand Disk Space:**
   ```bash
   # In AWS Console: EC2 → Volumes → Modify (8GB → 30GB)
   # Then SSH into server:
   ssh -i moltbot-key.pem ec2-user@54.174.12.251
   sudo xfs_growfs -d /
   ```

2. **Install Browser Dependencies:**
   ```bash
   sudo yum install -y alsa-lib at-spi2-atk at-spi2-core atk cairo cups-libs \
     dbus-libs expat gdk-pixbuf2 glib2 gtk3 libX11 libXcomposite libXcursor \
     libXdamage libXext libXfixes libXi libXrandr libXrender libXtst libdrm \
     libuuid pango xorg-x11-server-utils libgbm libasound
   ```

3. **Start with PM2:**
   ```bash
   cd ~/moltbot-urbanmistrii
   pm2 delete moltbot
   export NODE_OPTIONS="--max-old-space-size=1024"
   pm2 start npm --name "moltbot" -- start --update-env
   pm2 logs moltbot --raw  # Watch for QR code
   ```

### Option C: Zeabur Deployment

1. **Push to GitHub:**
   ```bash
   git add .
   git commit -m "Deploy to Zeabur"
   git push origin main
   ```

2. **Deploy on Zeabur:**
   - Connect GitHub repository
   - Zeabur will auto-detect `Dockerfile`
   - Set environment variables in Zeabur dashboard
   - Deploy!

---

## 📊 Current Status

| Deployment | Status | Notes |
|------------|--------|-------|
| **Local** | 🟡 In Progress | Currently testing WhatsApp connection |
| **AWS EC2** | 🔴 Blocked | Needs disk expansion + dependency install |
| **Zeabur** | 🟢 ACTIVE | Auto-deploying from GitHub. Watch Zeabur logs for QR code. |

---

## 🛠️ Troubleshooting

### WhatsApp Won't Connect
- Ensure only ONE instance is running (local OR AWS OR Zeabur)
- Delete `.clawdbot` folder and restart
- Check that your phone number is in the allowlist

### Out of Memory
- Increase `NODE_OPTIONS=--max-old-space-size=2048`
- On AWS: Add swap space or upgrade instance type

### Email/Instagram Not Working
- Verify environment variables are set
- Check API keys are valid
- Review logs in `workspace/email_inbox.json`

---

## 📝 Next Steps for Production

1. ✅ Test local WhatsApp connection
2. ⏳ Choose primary deployment (AWS or Zeabur)
3. ⏳ Set up Instagram credentials
4. ⏳ Configure email monitoring schedule
5. ⏳ Create backup/restore procedures
6. ⏳ Set up monitoring and alerts

---

## 🔐 Security Notes

- **Never commit** API keys to Git (use `.env` files)
- Rotate credentials regularly
- Use separate keys for dev/staging/production
- Enable 2FA on all accounts

---

**Last Updated:** 2026-01-31  
**Maintainer:** URBANMISTRII Team
