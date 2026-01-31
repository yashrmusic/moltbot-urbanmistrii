# 🏛️ Molt-Mistrii (Shaktiman): URBANMISTRII Content Director

**An autonomous WhatsApp-based AI agent for architectural content curation and publishing**

---

## 🤖 What Is This Bot?

**Molt-Mistrii** (nicknamed "Shaktiman") is a headless AI agent built on [Clawdbot](https://molt.bot) that autonomously manages URBANMISTRII's digital presence. It monitors Google Drive for new architectural imagery, generates design-led narratives, publishes to Instagram, and manages email communications—all through WhatsApp.

### Key Capabilities:
- 📸 **Google Drive Monitoring** - Watches `URBANMISTRII_PIPELINE` folder for new images
- 🎨 **AI-Powered Narratives** - Generates architectural storytelling captions using Gemini 1.5 Flash
- 📱 **Instagram Publishing** - Automated posting via Facebook Graph API
- 📧 **Email Management** - Monitors `mail@` and `hr@urbanmistrii.com` inboxes
- 💬 **WhatsApp Interface** - All interactions happen via WhatsApp for mobile-first control

---

## 🏗️ Architecture

```
┌─────────────────────────────────────────────────────────────┐
│                     MOLT-MISTRII SYSTEM                      │
├─────────────────────────────────────────────────────────────┤
│                                                               │
│  WhatsApp (User) ←→ Clawdbot Gateway ←→ Gemini 1.5 Flash    │
│                            ↓                                  │
│                    ┌───────────────┐                         │
│                    │  Python Skills │                         │
│                    ├───────────────┤                         │
│                    │ • Drive Watch  │                         │
│                    │ • Email Sync   │                         │
│                    │ • IG Publisher │                         │
│                    └───────────────┘                         │
│                            ↓                                  │
│         Google Drive • Gmail • Instagram Graph API           │
│                                                               │
└─────────────────────────────────────────────────────────────┘
```

### Tech Stack:
- **Runtime**: Node.js 22 + Python 3
- **AI Framework**: Clawdbot (Molt.bot)
- **AI Model**: Google Gemini 1.5 Flash
- **Deployment**: Zeabur (primary), AWS EC2 (backup)
- **Integrations**: WhatsApp, Google Drive, Gmail, Instagram

---

## 🚀 Deployment Options

### Option 1: Zeabur (Recommended - Zero Config)

**Why Zeabur?**
- Auto-deploys from GitHub pushes
- Built-in environment variable management
- Free tier available
- No server management

**Steps:**
1. Connect this GitHub repo to Zeabur
2. Set environment variables in Zeabur dashboard:
   ```
   GEMINI_API_KEY=AIzaSyCnmerxwYYt0vHPM6BWhxGljS2NRhzPpOM
   EMAIL_PASS_MAIL=<your_password>
   EMAIL_PASS_HR=<your_password>
   IG_USER_ID=<instagram_user_id>
   IG_ACCESS_TOKEN=<instagram_access_token>
   ```
3. Deploy and check logs for WhatsApp QR code
4. Scan QR code to link your WhatsApp account

**Current Status:** ✅ Configured and ready to deploy

---

### Option 2: AWS EC2 (Self-Hosted Backup)

**Server Details:**
- **IP**: `54.174.12.251`
- **Instance**: t2.micro (Ubuntu 24.04)
- **User**: `ec2-user`
- **Key**: `moltbot-key.pem`

**Deployment Steps:**

```bash
# 1. SSH into server
ssh -i moltbot-key.pem ec2-user@54.174.12.251

# 2. Clone/Update repo
cd ~
git clone https://github.com/yashrmusic/moltbot-urbanmistrii.git
cd moltbot-urbanmistrii

# 3. Install dependencies
npm install --omit=dev
pip3 install -r requirements.txt --break-system-packages

# 4. Set environment variables
export GEMINI_API_KEY="AIzaSyCnmerxwYYt0vHPM6BWhxGljS2NRhzPpOM"
export EMAIL_PASS_MAIL="<your_password>"
export EMAIL_PASS_HR="<your_password>"
export IG_USER_ID="<instagram_user_id>"
export IG_ACCESS_TOKEN="<instagram_access_token>"

# 5. Start with PM2
pm2 start npm --name "moltbot" -- start
pm2 save
pm2 startup

# 6. View logs for QR code
pm2 logs moltbot
```

**Terraform Deployment:**
```bash
# Initialize and apply infrastructure
terraform init
terraform apply

# Note: Update main.tf with your AWS credentials and key pair first
```

---

## 📁 Project Structure

```
moltbot-urbanmistrii/
├── .clawdbot/
│   └── clawdbot.json          # Clawdbot configuration
├── workspace/
│   ├── IDENTITY.md             # Bot personality and identity
│   ├── SOUL.md                 # Core behavioral guidelines
│   ├── USER.md                 # User context and preferences
│   ├── TOOLS.md                # Environment-specific tool configs
│   ├── DEPLOYMENT.md           # Deployment status tracker
│   └── tools/                  # Custom skills (future)
├── urbanmistrii_mail.py        # Email monitoring skill
├── urbanmistrii_instagram.py   # Instagram publishing skill
├── UrbanMistriiDrive.js        # Google Drive watcher (Apps Script)
├── Dockerfile                  # Container configuration
├── start.sh                    # Zeabur/Docker startup script
├── start_ec2.sh                # EC2 startup script
├── main.tf                     # Terraform AWS infrastructure
├── package.json                # Node.js dependencies
├── requirements.txt            # Python dependencies
└── README.md                   # This file
```

---

## 🔧 Configuration

### Model Configuration
The bot uses **Gemini 1.5 Flash** for all AI operations:

```json
{
  "model": {
    "primary": "google/gemini-1.5-flash",
    "planner": "google/gemini-1.5-flash",
    "cheap": "google/gemini-1.5-flash",
    "embedding": "google/text-embedding-004"
  }
}
```

This prevents fallback to Anthropic/Claude and keeps costs low.

### Environment Variables

| Variable | Purpose | Required |
|----------|---------|----------|
| `GEMINI_API_KEY` | Google AI API key | ✅ Yes |
| `EMAIL_PASS_MAIL` | Password for mail@urbanmistrii.com | For email features |
| `EMAIL_PASS_HR` | Password for hr@urbanmistrii.com | For email features |
| `IG_USER_ID` | Instagram Business Account ID | For Instagram posting |
| `IG_ACCESS_TOKEN` | Instagram Graph API token | For Instagram posting |

---

## 🎯 Usage

### Initial Setup (First Time)
1. Deploy the bot (Zeabur or EC2)
2. Check logs for WhatsApp QR code
3. Scan QR code with your WhatsApp account
4. Send "Hi" to the bot to verify connection

### Daily Operations
All interactions happen via WhatsApp. Example commands:

```
"Check for new images in Drive"
"Sync emails"
"Post this image to Instagram: [image_url] with caption: [text]"
"What's in my inbox?"
```

The bot is designed to be **96% autonomous** - it will proactively monitor folders and handle routine tasks without prompting.

---

## 🛠️ Skills & Integrations

### 1. Email Monitoring (`urbanmistrii_mail.py`)
- Monitors Gmail inboxes via IMAP
- Categorizes inquiries
- Saves results to `workspace/email_inbox.json`

**Test manually:**
```bash
python3 urbanmistrii_mail.py
```

### 2. Instagram Publishing (`urbanmistrii_instagram.py`)
- Posts images via Facebook Graph API
- Handles caption generation
- Returns post URLs

**Test manually:**
```bash
python3 urbanmistrii_instagram.py "https://example.com/image.jpg" "Caption text"
```

### 3. Google Drive Monitoring (`UrbanMistriiDrive.js`)
- Google Apps Script deployed via `clasp`
- Watches `URBANMISTRII_PIPELINE` folder
- Returns new image metadata

**Setup:**
```bash
npm install -g @google/clasp
clasp login
clasp create --type standalone
clasp push
```

---

## 🧪 Testing Checklist

After deployment, verify:

- [ ] WhatsApp connection established (QR code scanned)
- [ ] Bot responds to "Hi" message
- [ ] Email sync works: `python3 urbanmistrii_mail.py`
- [ ] Instagram posting works (test with sample image)
- [ ] No "Anthropic API" errors in logs
- [ ] Workspace files created (`workspace/email_inbox.json`)

---

## 🐛 Troubleshooting

### "No API key found for provider 'anthropic'"
**Solution:** Ensure all model roles are set to Gemini in config files:
- Check `clawdbot.json`, `start.sh`, `package.json`
- Verify `planner`, `cheap`, and `embedding` are all set to `google/gemini-1.5-flash`

### WhatsApp QR Code Not Appearing
**Solution:** Check logs for browser launch errors:
```bash
pm2 logs moltbot --lines 100
```
Install missing dependencies (see `RESUME_TOMORROW.md`)

### Out of Memory on EC2
**Solution:** Add swap space:
```bash
sudo fallocate -l 4G /swapfile
sudo chmod 600 /swapfile
sudo mkswap /swapfile
sudo swapon /swapfile
```

---

## 📚 Creating Future Bots

### Template Checklist

When creating a new Clawdbot-based agent:

1. **Identity Files** (in `workspace/`)
   - [ ] `IDENTITY.md` - Name, vibe, emoji, avatar
   - [ ] `SOUL.md` - Core behavior and mission
   - [ ] `USER.md` - User context and preferences
   - [ ] `TOOLS.md` - Environment-specific configs

2. **Configuration**
   - [ ] `.clawdbot/clawdbot.json` - Main config
   - [ ] `package.json` - Dependencies and start script
   - [ ] `Dockerfile` - Container setup
   - [ ] Environment variables documented

3. **Model Configuration**
   - [ ] Set `primary`, `planner`, `cheap`, `embedding` explicitly
   - [ ] Choose stable models (avoid beta/experimental)
   - [ ] Document API key requirements

4. **Skills/Integrations**
   - [ ] Create Python/Node scripts for external APIs
   - [ ] Test each skill independently
   - [ ] Document CLI usage for each skill

5. **Deployment**
   - [ ] Choose platform (Zeabur, Railway, EC2, etc.)
   - [ ] Create startup scripts
   - [ ] Document environment setup
   - [ ] Test deployment end-to-end

6. **Documentation**
   - [ ] README with architecture diagram
   - [ ] Deployment guide for each platform
   - [ ] Troubleshooting section
   - [ ] Testing checklist

---

## 🔗 Resources

- **Clawdbot Docs**: https://molt.bot/docs
- **Gemini API**: https://ai.google.dev/
- **Instagram Graph API**: https://developers.facebook.com/docs/instagram-api
- **Zeabur**: https://zeabur.com
- **GitHub Repo**: https://github.com/yashrmusic/moltbot-urbanmistrii

---

## 📝 License & Credits

**Built by:** Yash (with Antigravity AI assistance)  
**For:** URBANMISTRII  
**Framework:** Clawdbot by Molt.bot  
**AI Model:** Google Gemini 1.5 Flash  

---

## 🎭 Bot Personality

**Name:** Shaktiman  
**Role:** Headless Content Director  
**Vibe:** Architectural, precise, storytelling, autonomous  
**Emoji:** 🏛️  

*"I am the bridge between architecture and social storytelling for URBANMISTRII. I monitor folders, analyze spatial design, and handle the publishing pipeline with zero human intervention."*

---

**Status:** ✅ Configured and ready for deployment  
**Last Updated:** 2026-01-31  
**Version:** 1.0.0
