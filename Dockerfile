FROM node:22

LABEL language="nodejs"
LABEL framework="clawdbot"

# Install system dependencies + Python
RUN apt-get update && apt-get install -y \
    libnss3 \
    libatk1.0-0 \
    libatk-bridge2.0-0 \
    libcups2 \
    libdrm2 \
    libxkbcommon0 \
    libxcomposite1 \
    libxdamage1 \
    libxrandr2 \
    libgbm1 \
    libasound2 \
    libpango-1.0-0 \
    libpangocairo-1.0-0 \
    libxshmfence1 \
    libglib2.0-0 \
    libglu1-mesa \
    libcairo2-dev \
    libjpeg-dev \
    libpango1.0-dev \
    libgif-dev \
    build-essential \
    g++ \
    chromium \
    python3 \
    python3-pip \
    git \
    && rm -rf /var/lib/apt/lists/*

# Fix potential permissions and set environment
ENV HOME=/root
ENV DEBUG=clawdbot:*
ENV NODE_OPTIONS="--max-old-space-size=1024"
ENV PUPPETEER_SKIP_DOWNLOAD=true
ENV PUPPETEER_EXECUTABLE_PATH=/usr/bin/chromium
ENV CLAWDBOT_GATEWAY_MODE=local
ENV GEMINI_API_KEY=AIzaSyCnmerxwYYt0vHPM6BWhxGljS2NRhzPpOM

WORKDIR /app

# Copy package files
COPY package.json ./

# Install dependencies (including possible native builds)
RUN npm install --omit=dev --loglevel verbose

# Copy Python requirements & install
COPY requirements.txt ./
RUN pip3 install -r requirements.txt --break-system-packages

# Copy the rest of the project
COPY . .

# Make start script executable
RUN chmod +x /app/start.sh

# Expose Gateway port
EXPOSE 18789

# Use the dedicated start script
CMD ["/bin/bash", "/app/start.sh"]
