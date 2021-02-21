FROM ubuntu:latest AS base

ENV DEBIAN_FRONTEND=noninteractive

# Install Dependencies
RUN apt-get update && apt-get install -y \
    apt-transport-https \
    python3 \
    python3-dev \
    python3-pip \
    python3-venv \
    curl \
    wget \
    zsh \
    git && \
    apt-get install -y software-properties-common && \
    #remove apt lists 
    rm -rf /var/lib/apt/lists/* && \
    #zsh and oh-my-zsh
    chsh -s $(which zsh) && \
    wget https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh -O - | zsh || true && \
    #docker
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add - && \
    add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" && \
    apt-get install -y docker-ce docker-ce-cli containerd.io

# dot files
COPY dotfiles/* ~/ 

# Python Environments
RUN source ./.venv/activate


FROM base AS web

RUN curl -fsSL https://deb.nodesource.com/setup_15.x | bash - && \
    apt-get install -y nodejs


FROM nvidia/cuda:11.2.1-devel-ubuntu20.04 AS deeplearning

ENV DEBIAN_FRONTEND=noninteractive

# Install Dependencies
RUN apt-get update && apt-get install -y \
    apt-transport-https \
    python3 \
    python3-dev \
    python3-pip \
    python3-venv \
    curl \
    wget \
    zsh \
    git && \
    apt-get install -y software-properties-common && \
    rm -rf /var/lib/apt/lists/* && \
    chsh -s $(which zsh) && \
    wget https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh -O - | zsh || true && \
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add - && \
    add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" && \
    apt-get install -y docker-ce docker-ce-cli containerd.io

# dot files
COPY dotfiles/* ~/ 


# PyTorch
RUN pip3 install torch torchvision
