# 🚀 Quick Start: Deploy to DigitalOcean in 5 Minutes

**Choose your deployment method:**

---

## ⚡ EASIEST: DigitalOcean App Platform (Free)

### In 5 Steps:

1. **Visit**: https://cloud.digitalocean.com/apps

2. **Click**: "Create App" → Select GitHub → Choose `moltbot-urbanmistrii`

3. **Configure**:
   - Branch: `main`
   - Build: Node.js
   - Run Command: `npm start`

4. **Add Environment Variables** (click "Edit" → "Environment"):
   ```
   WHATSAPP_API_KEY=your_key
   GEMINI_API_KEY=your_key
   INSTAGRAM_ACCESS_TOKEN=your_token
   GOOGLE_DRIVE_FOLDER_ID=your_folder_id
   GMAIL_ADDRESS=your@email.com
   GMAIL_APP_PASSWORD=your_app_password
   NODE_ENV=production
   ```

5. **Deploy**: Click "Create Resource" → Wait 2-3 minutes ✅

**Cost**: FREE (within free tier)  
**Uptime**: 99.9%  
**Ease**: ⭐⭐⭐⭐⭐

---

## 💻 CHEAPER: DigitalOcean Droplet ($6/month)

### In 10 Steps:

1. Create Droplet: Ubuntu 24.04, $6/month size

2. SSH in:
   ```bash
   ssh root@your_droplet_ip
   ```

3. Install Node.js:
   ```bash
   curl -fsSL https://deb.nodesource.com/setup_22.x | sudo -E bash -
   apt install -y nodejs
   ```

4. Install Python:
   ```bash
   apt install -y python3 python3-pip
   ```

5. Install PM2 (keeps bot running):
   ```bash
   npm install -g pm2
   ```

6. Clone repo:
   ```bash
   cd /root && git clone https://github.com/yashrmusic/moltbot-urbanmistrii.git
   cd moltbot-urbanmistrii
   ```

7. Setup environment:
   ```bash
   cp .env.example .env
   nano .env    # Add your API keys
   ```

8. Install dependencies:
   ```bash
   npm install
   ```

9. Start bot:
   ```bash
   pm2 start npm --name "moltbot" -- start
   pm2 startup
   pm2 save
   ```

10. Check status:
    ```bash
    pm2 logs moltbot
    ```

**Cost**: $6/month (or free credits)  
**Uptime**: As reliable as you keep it  
**Ease**: ⭐⭐⭐

---

## 🐳 ADVANCED: Docker + Container Registry

Use the provided `Dockerfile.do` and `docker-compose.yml`:

```bash
# Build locally
docker build -f Dockerfile.do -t urbanmistrii-content-bot .

# Or deploy via App Platform with Docker
# (Same as App Platform option 1)
```

---

## 📋 Checklist Before Deploying

- [ ] GitHub account with repo access
- [ ] DigitalOcean account (free tier available)
- [ ] API Keys ready:
  - [ ] WhatsApp API Key
  - [ ] Gemini API Key
  - [ ] Instagram Access Token
  - [ ] Google Drive Folder ID
  - [ ] Gmail App Password

---

## 🎯 My Recommendation

**For you**: Use **App Platform (Option 1)**
- ✅ Completely FREE
- ✅ No server management
- ✅ Auto-scales
- ✅ Simpler to maintain
- ✅ Best for hobbyist/testing

---

## ❓ Need Help?

See full guide: `DIGITALOCEAN_DEPLOYMENT.md`

---

**Ready? Let's go! 🚀**
