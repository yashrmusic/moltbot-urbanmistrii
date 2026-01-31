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
# Using both formats (single and double underscore) for maximum compatibility with Clawdbot versions
export CLAWDBOT_AGENTS_DEFAULTS_MODEL_PRIMARY=google/gemini-1.5-flash
export CLAWDBOT_AGENTS_DEFAULTS_MODEL_PLANNER=google/gemini-1.5-flash
export CLAWDBOT_AGENTS_DEFAULTS_MODEL_CHEAP=google/gemini-1.5-flash
export CLAWDBOT_AGENTS_DEFAULTS_MODEL_EMBEDDING=google/text-embedding-004

export CLAWDBOT__AGENTS__DEFAULTS__MODEL__PRIMARY=google/gemini-1.5-flash
export CLAWDBOT__AGENTS__DEFAULTS__MODEL__PLANNER=google/gemini-1.5-flash
export CLAWDBOT__AGENTS__DEFAULTS__MODEL__CHEAP=google/gemini-1.5-flash
export CLAWDBOT__AGENTS__DEFAULTS__MODEL__EMBEDDING=google/text-embedding-004

export CLAWDBOT_PLUGINS_ENTRIES_WHATSAPP_ENABLED=true
export CLAWDBOT__PLUGINS__ENTRIES__WHATSAPP__ENABLED=true

export CLAWDBOT_AGENTS_DEFAULTS_WORKSPACE=/app/workspace
export CLAWDBOT__AGENTS__DEFAULTS__WORKSPACE=/app/workspace

export GEMINI_API_KEY=AIzaSyCnmerxwYYt0vHPM6BWhxGljS2NRhzPpOM

echo "--- ENSURING CONFIG FILE EXISTS (FULL CONFIG) ---"
if [ ! -f /root/.clawdbot/clawdbot.json ]; then
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
  }
}
EOF
fi

echo "--- RUNNING DOCTOR CHECK ---"
./node_modules/.bin/clawdbot doctor --fix || true

echo "--- LAUNCHING GATEWAY ---"
# Use direct binary with explicit flags to ensure it never blocks
./node_modules/.bin/clawdbot gateway --allow-unconfigured &

# Wait for process to start
PID=$!
echo "--- GATEWAY PID: $PID ---"

# Keep alive
wait $PID
