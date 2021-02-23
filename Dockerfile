FROM ubuntu:latest AS base

ENV DEBIAN_FRONTEND=noninteractive \
    HOME=/root \
    WORKON_HOME=/root/.virtualenvs \
    VIRTUALENVWRAPPER_PYTHON=/usr/bin/python3 

# Install Dependencies
RUN apt-get update > /dev/null && apt-get install -qq \
    apt-transport-https \
    python3 \
    python3-dev \
    python3-pip \
    curl \
    wget \
    iptables \
    unzip \
    zsh \
    git > /dev/null && \
    apt-get install -qq software-properties-common && \
    #remove apt lists 
    rm -rf /var/lib/apt/lists/* && \
    #python virtualenvs
    pip3 install -qq virtualenv virtualenvwrapper && \
    #docker
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add - && \
    add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" && \
    apt-get install -qq docker-ce docker-ce-cli containerd.io > /dev/null

# dot files. we are using root user  
#SHELL ["/bin/zsh", "-c"] 

RUN chsh -s $(which zsh) && \ 
    wget https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh -O - | zsh || true > /dev/null

COPY dotfiles/* ${HOME}/


SHELL ["/bin/zsh", "-c"]
RUN source /usr/local/bin/virtualenvwrapper.sh && \
    mkvirtualenv base && \
    workon base && \
    pip3 install -r ${HOME}/.requirements.txt


COPY scripts/base.sh /root/
RUN chmod +x /root/base.sh

ENTRYPOINT [ "/root/base.sh" ] 


FROM base AS web

ENV GOLANG_VERSION=1.16

#node 15 and deno
RUN curl -fsSL https://deb.nodesource.com/setup_15.x | bash - && \
    apt-get install -y nodejs && \
    curl -fsSL https://deno.land/x/install/install.sh | sh && \
    wget -c https://golang.org/dl/go${GOLANG_VERSION}.linux-amd64.tar.gz -O - | tar -xz -C /usr/local


ENTRYPOINT [ "zsh" ]

FROM base AS deeplearning
# PyTorch
RUN pip3 install torch torchvision
ENTRYPOINT [ "zsh" ]