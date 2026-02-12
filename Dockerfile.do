# Docker configuration for moltbot-urbanmistrii
# Optimized for DigitalOcean deployment

FROM node:22-alpine

# Install python and dependencies for Python skills
RUN apk add --no-cache python3 py3-pip

WORKDIR /app

# Copy package files
COPY package*.json ./

# Install Node dependencies
RUN npm ci --only=production

# Copy Python requirements
COPY requirements.txt* ./

# Install Python dependencies if they exist
RUN if [ -f requirements.txt ]; then pip3 install -r requirements.txt; fi

# Copy application code
COPY . .

# Create a non-root user for security
RUN addgroup -g 1001 -S nodejs && adduser -S nodejs -u 1001
USER nodejs

# Health check
HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --retries=3 \
  CMD node -e "require('http').get('http://localhost:3000/health', (r) => {if (r.statusCode !== 200) throw new Error(r.statusCode)})"

# Expose port
EXPOSE 3000

# Start command
CMD ["npm", "start"]
