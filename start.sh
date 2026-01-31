#!/bin/bash
set -ex

echo "--- SYSTEM DIAGNOSTIC ---"
whoami
pwd
node -v
npm -v

echo "--- CREATING CONFIG DIRECTORIES ---"
mkdir -p /root/.clawdbot /app/workspace

echo "--- GENERATING CLAWDBOT.JSON ---"
cat <<EOF > /root/.clawdbot/clawdbot.json
{
  "gateway": {
    "mode": "local",
    "auth": {
      "mode": "token",
      "token": "0189e4e6a5381635fcd090b1dbc63ba98542577f5f5abb4c"
    },
    "port": 18789
  },
  "agents": {
    "defaults": {
      "workspace": "/app/workspace",
      "model": {
        "primary": "google/gemini-2.0-flash"
      }
    }
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
EOF

echo "--- CONFIG VERIFICATION ---"
ls -la /root/.clawdbot/
cat /root/.clawdbot/clawdbot.json

echo "--- RUNNING DOCTOR CHECK ---"
npx clawdbot doctor --fix || true

echo "--- STARTING GATEWAY ---"
# Use npx directly with a clean path
export PATH="$PATH:/app/node_modules/.bin"
npx clawdbot gateway
