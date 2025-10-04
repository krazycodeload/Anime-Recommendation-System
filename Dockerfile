## Parent image
FROM python:3.10-slim

## Essential environment variables
ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1

## Work directory inside the docker container
WORKDIR /app

## Installing system dependancies
RUN apt-get update && apt-get install -y \
    build-essential \
    curl \
    gcc \
    libffi-dev \
    libssl-dev \
    && rm -rf /var/lib/apt/lists/*


# Install uv
RUN curl -Ls https://astral.sh/uv/install.sh | sh

# Add uv to PATH (it installs to /root/.cargo/bin)
ENV PATH="/root/.cargo/bin:${PATH}"

## Copying ur all contents from local to app
COPY . .

## Run setup.py
# RUN pip install --no-cache-dir -e .
RUN uv pip install -r requirements.txt

# Used PORTS
EXPOSE 8501

# Run the app 
CMD ["streamlit", "run", "app/app.py", "--server.port=8501", "--server.address=0.0.0.0","--server.headless=true"]