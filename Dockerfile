# ---------- Stage 1: Node.js Scraper ----------
    FROM node:18-slim AS scraper

    ENV PUPPETEER_SKIP_CHROMIUM_DOWNLOAD=true
    WORKDIR /app
    
    # Install Chromium and dependencies
    RUN apt-get update && apt-get install -y \
        chromium \
        fonts-liberation \
        libasound2 \
        libatk-bridge2.0-0 \
        libatk1.0-0 \
        libc6 \
        libcairo2 \
        libcups2 \
        libdbus-1-3 \
        libexpat1 \
        libfontconfig1 \
        libgbm1 \
        libgcc1 \
        libglib2.0-0 \
        libgtk-3-0 \
        libnspr4 \
        libnss3 \
        libpango-1.0-0 \
        libx11-6 \
        libxcomposite1 \
        libxdamage1 \
        libxext6 \
        libxfixes3 \
        libxrandr2 \
        libxrender1 \
        xdg-utils \
        ca-certificates \
     && rm -rf /var/lib/apt/lists/*
    
    COPY package.json .
    RUN npm install
    
    COPY scrape.js .
    
    ARG SCRAPE_URL
    ENV SCRAPE_URL=${SCRAPE_URL}
    RUN node scrape.js
    
    # ---------- Stage 2: Python Web Server ----------
    FROM python:3.10-slim
    
    WORKDIR /app
    
    COPY --from=scraper /app/scraped_data.json .
    COPY server.py requirements.txt ./
    
    RUN pip install --no-cache-dir -r requirements.txt
    
    EXPOSE 5000
    CMD ["python", "server.py"]
    