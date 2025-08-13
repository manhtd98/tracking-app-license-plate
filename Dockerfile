# ================================
# Base: PyTorch CPU image
# ================================
FROM cnstark/pytorch:2.2.2-py3.10.15-ubuntu22.04

ENV DEBIAN_FRONTEND=noninteractive \
    PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1 \
    PIP_NO_CACHE_DIR=1

# -----------------------------------
# Install system dependencies
# -----------------------------------
RUN apt-get update && apt-get install -y --no-install-recommends \
    ffmpeg \
    libgl1 \
    libglib2.0-0 \
    libsm6 \
    libxext6 \
    libxrender1 \
    git \
    build-essential \
  && rm -rf /var/lib/apt/lists/*

WORKDIR /app

# -----------------------------------
# Install Python dependencies
# -----------------------------------
COPY requirements.txt /app/requirements.txt

# Upgrade pip and install
RUN pip install --upgrade pip \
 && pip install opencv-python \
 && pip install -r requirements.txt

# If PaddleOCR / PaddlePaddle are not in requirements.txt:
# RUN pip install "paddlepaddle>=2.5,<3.0" -f https://www.paddlepaddle.org.cn/whl/linux/mkl/noavx.html
# RUN pip install "paddleocr>=2.7,<3.0"

# -----------------------------------
# Copy application code
# -----------------------------------
COPY . /app

ENTRYPOINT ["python", "main.py"]
