# Base image
FROM python:3.11-slim

# Install system dependencies
RUN apt-get update && apt-get install -y build-essential && rm -rf /var/lib/apt/lists/*

# Set working directory
WORKDIR /app

# Copy dependency file (if you have requirements.txt)
COPY requirements.txt .

# Install dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Copy your project files
COPY . .

# Set environment variable for port
ENV PORT=8080

# Expose port 8080
EXPOSE 8080

# Run FastAPI with Gunicorn (replace backend.app:app if needed)
CMD ["gunicorn", "backend.app:app", "-k", "uvicorn.workers.UvicornWorker", "--bind", "0.0.0.0:8080", "--workers", "2"]

