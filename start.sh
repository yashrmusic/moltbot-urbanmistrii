#!/bin/bash
set -ex

echo "--- SYSTEM DIAGNOSTIC ---"
whoami
pwd
node -v
npm -v

echo "--- CREATING CONFIG DIRECTORIES ---"
CLAWDBOT_HOME="${HOME}/.clawdbot"
WORKSPACE_DIR="$(pwd)/workspace"
mkdir -p "$CLAWDBOT_HOME" "$WORKSPACE_DIR"
chmod 700 "$CLAWDBOT_HOME"

echo "--- EXPORTING CRITICAL ENV VARS ---"
# Double underscores are the standard for nested config overrides in Clawdbot
export CLAWDBOT__AGENTS__DEFAULTS__MODEL__PRIMARY=google/gemini-2.5-flash

export CLAWDBOT__PLUGINS__ENTRIES__WHATSAPP__ENABLED=true
export CLAWDBOT__AGENTS__DEFAULTS__WORKSPACE=/app/workspace

if [ -z "${GEMINI_API_KEY:-}" ]; then
  echo "ERROR: GEMINI_API_KEY is not set."
  exit 1
fi

if [ -z "${CLAWDBOT_TOKEN:-}" ]; then
  echo "ERROR: CLAWDBOT_TOKEN is not set."
  exit 1
fi

echo "--- ENSURING CONFIG FILE EXISTS (FORCE OVERWRITE) ---"
# We force overwrite every time to ensure the model settings are never stale
cat <<EOF > "$CLAWDBOT_HOME/clawdbot.json"
{
  "gateway": {
    "mode": "local",
    "auth": {
      "mode": "token",
      "token": "${CLAWDBOT_TOKEN}"
    },
    "port": 18789
  },
  "agents": {
    "defaults": {
      "workspace": "$WORKSPACE_DIR",
      "model": {
        "primary": "google/gemini-2.5-flash"
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
  --model.primary google/gemini-2.5-flash \
  &

# Wait for process to start
PID=$!
echo "--- GATEWAY PID: $PID ---"

# Keep alive
wait $PID
