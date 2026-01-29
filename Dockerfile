# Moltbot 24/7 Deployment Dockerfile
FROM node:22

# Install dependencies for WhatsApp/Puppeteer + Python
RUN apt-get update && apt-get install -y \
    libnss3 \
    libatk-bridge2.0-0 \
    libxcomposite1 \
    libxdamage1 \
    libxrandr2 \
    libgbm1 \
    libasound2 \
    libpangocairo-1.0-0 \
    libxshmfence1 \
    python3 \
    python3-pip \
    git \
    && rm -rf /var/lib/apt/lists/*

COPY requirements.txt /app/requirements.txt
RUN pip3 install -r /app/requirements.txt --break-system-packages

WORKDIR /app

# Increase Node memory for large install
ENV NODE_OPTIONS="--max-old-space-size=4096"

# Install Moltbot globally with verbose logging to debug if it hangs
RUN npm install -g clawdbot --loglevel verbose

# Copy configuration and workspace
COPY .clawdbot /root/.clawdbot
COPY workspace /app/workspace

# Expose Gateway port
EXPOSE 18789

# Start Moltbot Gateway
CMD ["clawdbot", "gateway"]
