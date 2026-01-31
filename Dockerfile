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

# Environment variable to handle memory safely
ENV NODE_OPTIONS="--max-old-space-size=1024"

# Expose Gateway port
EXPOSE 18789

# Start command with better error handling
CMD ["npm", "start"]
