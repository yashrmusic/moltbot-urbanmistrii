#!/bin/bash
# MOLTBOT Startup Script for Amazon Linux

echo "--- STARTING MOLTBOT SETUP ---"
export CLAWDBOT_HOME=$HOME/.clawdbot
export WORKSPACE_DIR=$HOME/moltbot-urbanmistrii/workspace
export NODE_OPTIONS="--max-old-space-size=768"

mkdir -p "$CLAWDBOT_HOME" "$WORKSPACE_DIR"

echo "--- GENERATING CONFIG ---"
if [ ! -f "$CLAWDBOT_HOME/clawdbot.json" ]; then
cat > "$CLAWDBOT_HOME/clawdbot.json" <<EOC
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
      "workspace": "$WORKSPACE_DIR",
      "model": {
        "primary": "google/gemini-2.5-flash",
        "planner": "google/gemini-2.5-flash",
        "cheap": "google/gemini-2.5-flash",
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
EOC
else
  echo "--- CONFIG ALREADY EXISTS, SKIPPING GENERATION ---"
fi

echo "--- LAUNCHING GATEWAY (DIRECT) ---"
# We skip the doctor check to save memory on t2.micro
./node_modules/.bin/clawdbot gateway
