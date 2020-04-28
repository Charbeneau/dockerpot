FROM python:3.7.7-slim-buster

RUN apt-get update && apt-get -y install \
    gcc

RUN echo 'Installing Python packages.'
ADD requirements.txt /
RUN pip install -r /requirements.txt

ADD data/ /workspace/data
ADD notebooks/ /workspace/notebooks
ADD scripts/ /workspace/scripts
ADD docker-entrypoint.sh /workspace/docker-entrypoint.sh
RUN chmod +x /workspace/docker-entrypoint.sh

WORKDIR /workspace

EXPOSE 8888

ENTRYPOINT ["/workspace/docker-entrypoint.sh"]
