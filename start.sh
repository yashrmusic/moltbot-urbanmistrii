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
# This is the most reliable way to bypass config file issues
export CLAWDBOT_GATEWAY_MODE=local
export CLAWDBOT_GATEWAY_PORT=18789
export CLAWDBOT_GATEWAY_AUTH_MODE=token
export CLAWDBOT_GATEWAY_AUTH_TOKEN=0189e4e6a5381635fcd090b1dbc63ba98542577f5f5abb4c
export CLAWDBOT_AGENTS_DEFAULTS_MODEL_PRIMARY=google/gemini-1.5-flash

echo "--- ENSURING CONFIG FILE EXISTS (FALLBACK) ---"
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
