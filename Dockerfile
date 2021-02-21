FROM ubuntu:latest AS base

# Install Dependencies
RUN apt update && apt install -y \
    python3 \
    python3-dev \
    python3-pip \
    python3-venv \
    curl \
    wget \
    zsh \
    git && \
    rm -rf /var/lib/apt/lists/* && \
    chsh -s $(which zsh) && \
    wget https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh -O - | zsh || true

# dot files
COPY dotfiles/* ~/ 


FROM base AS web

RUN echo "node"


FROM nvidia/cuda:11.2.1-devel-ubuntu20.04 AS deeplearning

# Install Dependencies
RUN apt update && apt install -y \
    python3 \
    python3-dev \
    python3-pip \
    python3-venv \
    curl \
    wget \
    zsh \
    git && \
    rm -rf /var/lib/apt/lists/* && \
    chsh -s $(which zsh) && \
    wget https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh -O - | zsh || true

# dot files
COPY dotfiles/* ~/ 


# PyTorch
RUN pip3 install torch torchvision
