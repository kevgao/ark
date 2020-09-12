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

# PyTorch
RUN pip3 install torch torchvision

# ZSH and Oh-My-ZSH
RUN chsh -s $(which zsh) && \
    wget https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh -O - | zsh || true


# dot files
COPY ./dotfiles/.aliases ~/


# Python Virtualenv
RUN pip3 install virtualenv virtualenvwrapper && \
    sed -i '$ a\export WORKON_HOME=~/.virtualenvs' ~/.zshrc && \
    sed -i '$ a\source /usr/local/bin/virtualenvwrapper.sh &>/dev/null' ~/.zshrc





