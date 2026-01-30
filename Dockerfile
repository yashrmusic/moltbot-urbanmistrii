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

# Copy package files
COPY package.json ./

# Install dependencies
RUN npm install --omit=dev --loglevel verbose

# Copy Python requirements & install
COPY requirements.txt ./
RUN pip3 install -r requirements.txt --break-system-packages

# Copy the rest of the project
COPY . .

# Copy config to the location Moltbot expects
RUN mkdir -p /root/.clawdbot && cp -r .clawdbot/* /root/.clawdbot/ || true

# Environment variable to handle memory safely
ENV NODE_OPTIONS="--max-old-space-size=1024"

# Expose Gateway port
EXPOSE 18789

# Start command
CMD ["npm", "start"]
