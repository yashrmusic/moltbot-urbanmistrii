# 🚀 DigitalOcean Deployment Guide

## urbanmistrii-content-bot (Molt-Mistrii)

Deploy your bot for free on DigitalOcean with this step-by-step guide.

---

## 📋 Prerequisites

1. **DigitalOcean Account** (free tier available)
2. **GitHub Account** (repo access)
3. **Environment Variables** (API keys):
   - `WHATSAPP_API_KEY` - WhatsApp Business API key
   - `GEMINI_API_KEY` - Google Gemini API key
   - `INSTAGRAM_ACCESS_TOKEN` - Facebook Graph API token
   - `GOOGLE_DRIVE_FOLDER_ID` - Folder ID to monitor
   - `GMAIL_ADDRESS` - Gmail account email
   - `GMAIL_APP_PASSWORD` - Gmail app password

---

## 🎯 Option 1: DigitalOcean App Platform (RECOMMENDED - Free)

### Step 1: Push to GitHub
```bash
cd moltbot-urbanmistrii
git remote add origin https://github.com/yashrmusic/moltbot-urbanmistrii.git
git push -u origin main
```

### Step 2: Create App on DigitalOcean
1. Go to [DigitalOcean Apps](https://cloud.digitalocean.com/apps)
2. Click **"Create App"**
3. Select **"GitHub"** as source
4. Choose the `moltbot-urbanmistrii` repository
5. Select **`main`** branch
6. Choose **"Node.js"** as the build type

### Step 3: Configure Environment Variables
In the App Platform dashboard:
1. Click **"Environment"**
2. Add these secrets (mark as Secret):
   ```
   WHATSAPP_API_KEY=your_key_here
   GEMINI_API_KEY=your_key_here
   INSTAGRAM_ACCESS_TOKEN=your_token_here
   GOOGLE_DRIVE_FOLDER_ID=your_folder_id_here
   GMAIL_ADDRESS=your_email@gmail.com
   GMAIL_APP_PASSWORD=your_app_password_here
   NODE_ENV=production
   ```

### Step 4: Configure Build Settings
- **Build Command**: `npm install`
- **Run Command**: `npm start`
- **Port**: `3000`

### Step 5: Review & Deploy
- Check the `app.yaml` configuration
- Click **"Create Resource"**
- Wait for deployment (2-3 minutes)
- Your bot will be live at: `https://urbanmistrii-content-bot-xxxx.ondigitalocean.app`

**Cost**: FREE on App Platform (within free tier limits)

---

## 🎯 Option 2: DigitalOcean Droplet ($5-6/month)

### Step 1: Create Droplet
1. Go to [DigitalOcean Droplets](https://cloud.digitalocean.com/droplets)
2. Click **"Create Droplet"**
3. Choose:
   - **Region**: Your closest region
   - **Image**: Ubuntu 24.04
   - **Size**: $6/month (Basic - 1 GB RAM, 25 GB SSD)
   - **Authentication**: SSH Key (recommended)

### Step 2: SSH into Droplet
```bash
ssh root@your_droplet_ip
```

### Step 3: Install Dependencies
```bash
# Update system
apt update && apt upgrade -y

# Install Node.js
curl -fsSL https://deb.nodesource.com/setup_22.x | sudo -E bash -
apt install -y nodejs

# Install Python
apt install -y python3 python3-pip

# Install Docker (optional, for easier scaling)
curl -fsSL https://get.docker.com -o get-docker.sh
sh get-docker.sh

# Install PM2 (process manager)
npm install -g pm2
```

### Step 4: Clone Repository
```bash
cd /root
git clone https://github.com/yashrmusic/moltbot-urbanmistrii.git
cd moltbot-urbanmistrii
```

### Step 5: Setup Environment
```bash
cp .env.example .env
# Edit .env with your API keys
nano .env
```

### Step 6: Install & Start Bot
```bash
npm install
npm install -g pm2

# Start with PM2
pm2 start npm --name "moltbot" -- start
pm2 startup
pm2 save
```

### Step 7: Monitor
```bash
pm2 logs moltbot
pm2 status
```

**Cost**: $6/month (or use free credits if new account)

---

## 🐳 Option 3: Docker + DigitalOcean Container Registry

### Step 1: Build Docker Image Locally
```bash
cd moltbot-urbanmistrii
docker build -f Dockerfile.do -t urbanmistrii-content-bot:latest .
```

### Step 2: Create DigitalOcean Container Registry
1. Go to [Container Registry](https://cloud.digitalocean.com/registry)
2. Create a new registry (free)
3. Note your registry name

### Step 3: Push Image
```bash
# Login to DigitalOcean Registry
doctl auth init  # Set your token
doctl registry login

# Tag image
docker tag urbanmistrii-content-bot:latest registry.digitalocean.com/your-registry/urbanmistrii-content-bot:latest

# Push
docker push registry.digitalocean.com/your-registry/urbanmistrii-content-bot:latest
```

### Step 4: Deploy to App Platform
1. In App Platform, select Docker as source
2. Point to your registry image
3. Configure environment variables (same as Option 1)
4. Deploy!

---

## ✅ Post-Deployment Checklist

After deployment:

- [ ] Bot is running (`pm2 status` or check logs)
- [ ] WhatsApp messages are received
- [ ] Google Drive is being monitored
- [ ] Instagram posts are publishing
- [ ] Emails are being processed
- [ ] Environment variables are set correctly
- [ ] Logs are accessible

### Check Logs
```bash
# On Droplet
pm2 logs moltbot

# On App Platform
# Click "Runtime Logs" in dashboard
```

### Restart if Needed
```bash
# On Droplet
pm2 restart moltbot

# On App Platform
# Click "Restart App" in dashboard
```

---

## 🔧 Troubleshooting

### Bot crashes on startup
```bash
# Check logs
pm2 logs moltbot --lines 50

# Verify dependencies
npm install
python3 -m pip install -r requirements.txt
```

### Out of memory
- Upgrade Droplet size
- Or use App Platform auto-scaling

### API key not working
- Verify keys in `.env` file
- Check API service status
- Regenerate keys if needed

### Port already in use
```bash
# Kill process on port 3000
lsof -ti:3000 | xargs kill -9
```

---

## 📊 Cost Comparison

| Option | Cost | Free Tier | Ease | Auto-Scale |
|--------|------|-----------|------|-----------|
| **App Platform** | FREE | ✅ Yes | ⭐⭐⭐⭐⭐ | ✅ Auto |
| **Droplet** | $6/mo | ✅ Credits | ⭐⭐⭐ | ❌ Manual |
| **Docker** | $6/mo | ✅ Credits | ⭐⭐ | ✅ K8s |

**Recommendation**: Start with **App Platform** for simplicity and zero cost! 🚀

---

## 🎯 Next Steps

1. **Monitor Performance**: Set up alerts in DigitalOcean
2. **Setup Backups**: Enable automatic backups (if using Droplet)
3. **Custom Domain**: Point your domain to the deployment
4. **Scaling**: Upgrade as your bot handles more traffic

---

**Questions?** Check DigitalOcean docs: https://www.digitalocean.com/docs/
