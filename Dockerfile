FROM python:3.6
ENV LANG C.UTF-8
ENV LC_ALL C.UTF-8
ENV DEBIAN_FRONTEND=noninteractive TERM=linux

EXPOSE 8801

RUN apt-get update && \
    apt-get install -y --no-install-recommends git ca-certificates build-essential python-dev python3-dev

RUN pip3 install pipenv

RUN git clone https://github.com/mikeaveli007/airnotifier /airnotifier

RUN mkdir -p /var/airnotifier/pemdir && \
    mkdir -p /var/log/airnotifier

VOLUME ["/airnotifier", "/var/log/airnotifier", "/var/airnotifier/pemdir"]
WORKDIR /airnotifier

ADD ./config.py /airnotifier

RUN pipenv install --deploy

ADD start.sh /airnotifier
RUN chmod a+x /airnotifier/start.sh
ENTRYPOINT /airnotifier/start.sh
