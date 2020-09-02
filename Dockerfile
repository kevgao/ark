FROM nvidia/cuda:latest

# Install Dependencies
RUN apt update && apt install -y \
    python3 \
    python3-dev \
    python3-pip \
    curl \
    wget \
    zsh \
    git 

# ZSH and Oh-My-ZSH
RUN chsh -s $(which zsh) && \
    wget https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh -O - | zsh || true

# Alias
RUN alias python=python3 &&\
    alias pip=pip3

# Python Virtualenv
RUN pip3 install virtualenv virtualenvwrapper && \
    sed -i '$ a\export WORKON_HOME=~/.virtualenvs' ~/.zshrc && \
    sed -i '$ a\source /usr/local/bin/virtualenvwrapper.sh &>/dev/null' ~/.zshrc
# Python packages

# PyTorch
RUN pip3 install torch torchvision



