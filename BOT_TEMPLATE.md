# 🤖 Clawdbot Agent Template

**A step-by-step guide for creating autonomous AI agents with Clawdbot**

---

## 📋 Overview

This template helps you create new Clawdbot-based agents like **Molt-Mistrii**. Follow this checklist to ensure your bot is properly configured, deployed, and documented.

---

## 🎯 Step 1: Define Your Bot's Identity

### Create `workspace/IDENTITY.md`

```markdown
# IDENTITY.md - Who Am I?

- **Name:** [Your Bot's Name]
- **Creature:** [What kind of entity is this? AI assistant, autonomous agent, etc.]
- **Vibe:** [Personality traits: professional, casual, technical, creative, etc.]
- **Emoji:** [Signature emoji]
- **Avatar:** [Link or description]

---

[Brief description of the bot's purpose and role]
```

**Example:**
```markdown
- **Name:** Shaktiman
- **Creature:** Headless Content Director for URBANMISTRII
- **Vibe:** Architectural, precise, storytelling, autonomous
- **Emoji:** 🏛️
```

---

## 🧠 Step 2: Define Core Behavior

### Create `workspace/SOUL.md`

```markdown
# SOUL.md - Core Behavior

## Core Truths

[Define the bot's fundamental principles]

## Mission Logic

1. **Observe**: [What does the bot monitor?]
2. **Analyze**: [How does it process information?]
3. **Act**: [What actions does it take?]
4. **Report**: [How does it communicate results?]

## Vibe

[Tone, style, and interaction patterns]
```

**Key Questions:**
- What is the bot's primary mission?
- What are its behavioral guidelines?
- How should it interact with users?
- What are its boundaries and limitations?

---

## 👤 Step 3: Document User Context

### Create `workspace/USER.md`

```markdown
# USER.md - About Your Human

- **Name:** 
- **What to call them:** 
- **Timezone:** 
- **Notes:** 

## Context

- **About them:** [Role, interests, projects]
- **Preferences:** [Communication style, priorities]
```

---

## 🛠️ Step 4: Configure Tools & Environment

### Create `workspace/TOOLS.md`

```markdown
# TOOLS.md - Environment-Specific Configuration

## API Keys & Credentials
- [Service Name]: [Where to find/how to set]

## External Integrations
- [Integration Name]: [Purpose and setup]

## Device/Infrastructure
- [Servers, cameras, IoT devices, etc.]
```

---

## ⚙️ Step 5: Clawdbot Configuration

### Create `.clawdbot/clawdbot.json`

```json
{
  "messages": {
    "ackReactionScope": "group-mentions"
  },
  "agents": {
    "defaults": {
      "maxConcurrent": 4,
      "workspace": "/app/workspace",
      "model": {
        "primary": "google/gemini-1.5-flash",
        "planner": "google/gemini-1.5-flash",
        "cheap": "google/gemini-1.5-flash",
        "embedding": "google/text-embedding-004"
      }
    }
  },
  "gateway": {
    "mode": "local",
    "auth": {
      "mode": "token",
      "token": "[GENERATE_RANDOM_TOKEN]"
    },
    "port": 18789
  },
  "plugins": {
    "entries": {
      "whatsapp": {
        "enabled": true
      }
    }
  },
  "hooks": {
    "internal": {
      "enabled": true,
      "entries": {
        "boot-md": { "enabled": true },
        "command-logger": { "enabled": true },
        "session-memory": { "enabled": true }
      }
    }
  }
}
```

**Important:**
- ✅ Always set ALL model roles (`primary`, `planner`, `cheap`, `embedding`)
- ✅ Use stable models (avoid beta/experimental)
- ✅ Generate a unique auth token for security

---

## 📦 Step 6: Package Configuration

### Create `package.json`

```json
{
  "name": "your-bot-name",
  "version": "1.0.0",
  "description": "Brief description of your bot",
  "main": "index.js",
  "scripts": {
    "start": "clawdbot gateway"
  },
  "dependencies": {
    "clawdbot": "latest"
  },
  "engines": {
    "node": ">=22"
  }
}
```

### Create `requirements.txt` (if using Python skills)

```
requests
google-generativeai
imaplib
smtplib
```

---

## 🐳 Step 7: Docker Configuration

### Create `Dockerfile`

```dockerfile
FROM node:22

# Install system dependencies
RUN apt-get update && apt-get install -y \
    python3 \
    python3-pip \
    chromium \
    && rm -rf /var/lib/apt/lists/*

# Set environment
ENV HOME=/root
ENV PUPPETEER_SKIP_DOWNLOAD=true
ENV PUPPETEER_EXECUTABLE_PATH=/usr/bin/chromium
ENV GEMINI_API_KEY=your_api_key_here

WORKDIR /app

# Install dependencies
COPY package.json ./
RUN npm install --omit=dev

COPY requirements.txt ./
RUN pip3 install -r requirements.txt --break-system-packages

# Copy project files
COPY . .

# Expose gateway port
EXPOSE 18789

# Start bot
CMD ["npm", "start"]
```

### Create `start.sh`

```bash
#!/bin/bash
set -ex

echo "--- STARTING BOT SETUP ---"
mkdir -p /root/.clawdbot /app/workspace

echo "--- EXPORTING ENV VARS ---"
export CLAWDBOT_GATEWAY_MODE=local
export CLAWDBOT_GATEWAY_PORT=18789
export CLAWDBOT_AGENTS_DEFAULTS_MODEL_PRIMARY=google/gemini-1.5-flash
export CLAWDBOT_AGENTS_DEFAULTS_MODEL_PLANNER=google/gemini-1.5-flash
export CLAWDBOT_AGENTS_DEFAULTS_MODEL_CHEAP=google/gemini-1.5-flash
export GEMINI_API_KEY=your_api_key_here

echo "--- LAUNCHING GATEWAY ---"
./node_modules/.bin/clawdbot gateway &

PID=$!
echo "--- GATEWAY PID: $PID ---"
wait $PID
```

---

## 🚀 Step 8: Deployment Options

### Option A: Zeabur (Recommended)

1. **Connect GitHub repo to Zeabur**
2. **Set environment variables:**
   - `GEMINI_API_KEY`
   - [Any other API keys/credentials]
3. **Deploy and monitor logs**
4. **Scan WhatsApp QR code**

### Option B: AWS EC2

1. **Launch EC2 instance** (Ubuntu 24.04, t2.micro+)
2. **Install dependencies:**
   ```bash
   curl -fsSL https://deb.nodesource.com/setup_22.x | bash -
   apt-get install -y nodejs git python3 python3-pip
   npm install -g pm2
   ```
3. **Clone repo and install:**
   ```bash
   git clone [your-repo-url]
   cd [your-bot-directory]
   npm install --omit=dev
   pip3 install -r requirements.txt --break-system-packages
   ```
4. **Start with PM2:**
   ```bash
   pm2 start npm --name "your-bot" -- start
   pm2 save
   pm2 startup
   ```

### Option C: Railway / Render / Fly.io

Similar to Zeabur - connect repo, set env vars, deploy.

---

## 🧪 Step 9: Testing Checklist

After deployment:

- [ ] Bot starts without errors
- [ ] WhatsApp QR code appears in logs
- [ ] QR code scan successful
- [ ] Bot responds to test message
- [ ] No "Anthropic API" or model errors
- [ ] Custom skills work independently
- [ ] Workspace files created correctly
- [ ] Environment variables loaded
- [ ] Memory/session persistence works

---

## 📝 Step 10: Documentation

### Create `README.md`

Include:
1. **Overview** - What the bot does
2. **Architecture** - Diagram and tech stack
3. **Deployment** - Step-by-step for each platform
4. **Configuration** - Environment variables and settings
5. **Usage** - Example commands and interactions
6. **Skills** - List and test each integration
7. **Troubleshooting** - Common issues and solutions
8. **Resources** - Links to docs and APIs

### Create `DEPLOYMENT.md` (in workspace/)

Track:
- Current deployment status
- Configuration changes
- Next steps
- Testing results

---

## 🔧 Common Patterns

### Pattern 1: Email Monitoring

```python
import imaplib
import os

def get_unread_emails(user, password):
    mail = imaplib.IMAP4_SSL("imap.gmail.com")
    mail.login(user, password)
    mail.select("inbox")
    status, messages = mail.search(None, 'UNSEEN')
    # Process messages...
    return results
```

### Pattern 2: Social Media Publishing

```python
import requests

def post_to_instagram(image_url, caption):
    # Create container
    response = requests.post(
        f"https://graph.facebook.com/v21.0/{user_id}/media",
        data={"image_url": image_url, "caption": caption, "access_token": token}
    )
    # Publish container...
    return result
```

### Pattern 3: File Monitoring

```javascript
function watchFolder(folderName) {
  const folders = DriveApp.getFoldersByName(folderName);
  const folder = folders.next();
  const files = folder.getFiles();
  // Process new files...
  return fileList;
}
```

---

## 🐛 Troubleshooting Guide

### Issue: "No API key found for provider 'anthropic'"
**Solution:** Ensure ALL model roles are explicitly set to Gemini:
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

### Issue: WhatsApp QR code not appearing
**Solution:** Check browser dependencies:
```bash
# Ubuntu/Debian
apt-get install -y chromium libnss3 libatk1.0-0 libgbm1

# Amazon Linux
yum install -y chromium alsa-lib at-spi2-core
```

### Issue: Out of memory
**Solution:** Add swap space or increase instance size:
```bash
fallocate -l 4G /swapfile
chmod 600 /swapfile
mkswap /swapfile
swapon /swapfile
```

---

## 📚 Resources

- **Clawdbot Docs**: https://molt.bot/docs
- **Gemini API**: https://ai.google.dev/
- **Node.js**: https://nodejs.org/
- **PM2**: https://pm2.keymetrics.io/
- **Docker**: https://docs.docker.com/

---

## ✅ Final Checklist

Before launching your bot:

- [ ] Identity files complete (`IDENTITY.md`, `SOUL.md`, `USER.md`, `TOOLS.md`)
- [ ] Clawdbot config with all model roles set
- [ ] Package.json and dependencies installed
- [ ] Dockerfile and startup scripts created
- [ ] Environment variables documented
- [ ] Skills tested independently
- [ ] Deployment platform chosen
- [ ] README with full documentation
- [ ] Testing checklist completed
- [ ] Troubleshooting guide written

---

**Happy bot building! 🤖**

*Based on the Molt-Mistrii (Shaktiman) project for URBANMISTRII*
