FROM ubuntu:latest
WORKDIR /app
RUN apt update ; apt upgrade -y ; apt install python3 python3-pip aapt git git-lfs openjdk-8-jdk apktool -y --no-install-recommends
RUN git config --global user.name "Example"
RUN git config --global user.email "example@example.com"
RUN git clone -b main --depth=1 https://gitlab.com/nikgapps/13.git
RUN git clone -b main --depth=1 https://github.com/nikgapps/overlays_T.git
COPY script.sh .
RUN chmod +x script.sh
RUN python3 -m pip install NikGapps
ENTRYPOINT ["bash", "script.sh"]