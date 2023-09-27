FROM ubuntu:latest

WORKDIR /app

# Install required packages in a single RUN command to reduce layer size
RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
    python3 python3-pip aapt gcc python3-dev git git-lfs openjdk-8-jdk apktool && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Set git user configuration
RUN git config --global user.name "Example" && \
    git config --global user.email "example@example.com"

# Copy the script and make it executable
COPY script.sh .
RUN chmod +x script.sh

# Install NikGapps using pip
RUN python3 -m pip install NikGapps

ENTRYPOINT ["bash", "script.sh"]
