FROM ubuntu:22.04

COPY code-server_4.91.1_amd64.deb entrypoint.sh /

RUN apt update && apt install python3.10 python3-pip -y && \
        pip install torch==2.1.0 torchvision==0.16.0 torchaudio==2.1.0 --index-url https://download.pytorch.org/whl/cu121 && \
        pip install tensorboard jupyterlab --index-url https://pypi.tuna.tsinghua.edu.cn/simple && \
        dpkg -i /code-server_4.91.1_amd64.deb && \
        rm /code-server_4.91.1_amd64.deb && \
        code-server --install-extension ms-python.python && \
        ln -s /usr/bin/python3 /usr/bin/python && \
        mkdir -p /workspace

WORKDIR /workspace

ENTRYPOINT /entrypoint.sh
