FROM nvidia/cuda:latest

# Install Dependencies
RUN apt update && apt install -y \
    #python \
    #python-dev \
    #python-pip \
    #python-virtualenv \
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


# Python Virtualenv
RUN pip3 install virtualenv virtualenvwrapper && \
    sed -i '$ a\export WORKON_HOME=~/.virtualenvs' ~/.zshrc && \
    sed -i '$ a\source /usr/local/bin/virtualenvwrapper.sh &>/dev/null' ~/.zshrc
# Python packages

# PyTorch
RUN pip3 install torch torchvision  

# TensorFlow
#RUN pip install --upgrade tensorflow-gpu && \
#    pip3 install --upgrade tensorflow-gpu

    





        
    
    



