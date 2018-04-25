FROM nvidia/cuda:9.1-cudnn7-devel

# Install Dependencies
RUN apt update && apt install -y \
    python \
    python-dev \
    python-pip \
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
RUN pip install virtualenv virtualenvwrapper && \
    sed -i '$ a\export WORKON_HOME=~/.virtualenvs' ~/.zshrc && \
    sed -i '$ a\source /usr/local/bin/virtualenvwrapper.sh &>/dev/null' ~/.zshrc
# Python packages

# PyTorch
RUN pip3 install http://download.pytorch.org/whl/cu91/torch-0.4.0-cp35-cp35m-linux_x86_64.whl  && \
    pip3 install torchvision && \
    pip install http://download.pytorch.org/whl/cu91/torch-0.4.0-cp27-cp27mu-linux_x86_64.whl  && \
    pip install torchvision

# TensorFlow
#RUN pip install --upgrade tensorflow-gpu && \
#    pip3 install --upgrade tensorflow-gpu

    





        
    
    



