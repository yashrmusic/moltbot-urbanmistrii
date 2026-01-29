# Moltbot 24/7 Deployment Dockerfile
FROM node:22

# Install system dependencies + Python
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

WORKDIR /app

# Copy package files first
COPY package.json ./

# Install dependencies with strict production flag (lighter)
RUN npm install --omit=dev --loglevel verbose

# Copy Python requirements & install
COPY requirements.txt ./
RUN pip3 install -r requirements.txt --break-system-packages

# Copy the rest of the project
COPY . .

# Copy the local .clawdbot config to the root (where Moltbot expects it)
RUN cp -r .clawdbot /root/.clawdbot

# Expose Gateway port
EXPOSE 18789

# Start via npm script
CMD ["npm", "start"]
