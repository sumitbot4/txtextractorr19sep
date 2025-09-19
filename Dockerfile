# Python Based Docker
FROM python:3.11-slim

# Set environment variables (prevents Python from writing .pyc & buffering stdout)
ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

# Installing system packages (build tools + runtime tools)
RUN apt-get update && apt-get upgrade -y && \
    apt-get install -y --no-install-recommends \
        git curl ffmpeg aria2 build-essential python3-dev && \
    rm -rf /var/lib/apt/lists/*

# Upgrade pip/setuptools/wheel
RUN pip install --upgrade pip setuptools wheel

# Copy requirements first (better Docker caching)
COPY requirements.txt /tmp/requirements.txt

# Install Python dependencies
RUN pip install --no-cache-dir -r /tmp/requirements.txt

# Create working directory
WORKDIR /EXTRACTOR

# Copy entrypoint script
COPY start.sh /start.sh

# Run script
CMD ["/bin/bash", "/start.sh"]
