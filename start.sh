#!/bin/bash
set -ex

echo "--- SYSTEM DIAGNOSTIC ---"
whoami
pwd
node -v
npm -v

echo "--- CREATING CONFIG DIRECTORIES ---"
mkdir -p /root/.clawdbot /app/workspace
chmod 700 /root/.clawdbot

echo "--- EXPORTING CRITICAL ENV VARS ---"
# Double underscores are the standard for nested config overrides in Clawdbot
export CLAWDBOT__AGENTS__DEFAULTS__MODEL__PRIMARY=google/gemini-1.5-flash
export CLAWDBOT__AGENTS__DEFAULTS__MODEL__PLANNER=google/gemini-1.5-flash
export CLAWDBOT__AGENTS__DEFAULTS__MODEL__CHEAP=google/gemini-1.5-flash
export CLAWDBOT__AGENTS__DEFAULTS__MODEL__EMBEDDING=google/text-embedding-004

export CLAWDBOT__PLUGINS__ENTRIES__WHATSAPP__ENABLED=true
export CLAWDBOT__AGENTS__DEFAULTS__WORKSPACE=/app/workspace
export GEMINI_API_KEY=AIzaSyCnmerxwYYt0vHPM6BWhxGljS2NRhzPpOM

echo "--- ENSURING CONFIG FILE EXISTS (FORCE OVERWRITE) ---"
# We force overwrite every time to ensure the model settings are never stale
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
        "primary": "google/gemini-1.5-flash",
        "planner": "google/gemini-1.5-flash",
        "cheap": "google/gemini-1.5-flash",
        "embedding": "google/text-embedding-004"
      }
    }
  },
  "plugins": {
    "entries": {
      "whatsapp": {
        "enabled": true
      }
    }
  }
}
EOF

echo "--- RUNNING DOCTOR ---"
./node_modules/.bin/clawdbot doctor --fix || true

echo "--- LAUNCHING GATEWAY ---"
# Adding explicit CLI flags to override any hidden defaults
# These flags are the highest priority in the configuration hierarchy
./node_modules/.bin/clawdbot gateway \
  --allow-unconfigured \
  --model.primary google/gemini-1.5-flash \
  --model.planner google/gemini-1.5-flash \
  --model.cheap google/gemini-1.5-flash \
  &

# Wait for process to start
PID=$!
echo "--- GATEWAY PID: $PID ---"

# Keep alive
wait $PID
