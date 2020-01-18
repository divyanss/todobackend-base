FROM ubuntu:trusty-20150228.11 
# base image form bockerhub     docker pull ubuntu:trusty 
MAINTAINER Divyansh Saxen <divyanshsaxena00@gmail.com>


# Prevent dpkg errors
ENV TERM=xterm-256color

# set mirrors to NZpwd

#RUN sed -i "s/http:\/\/archive./http:\/\/nz.archive./g" /etc/apt/sources.list

# Install Python runtime
RUN apt-get update && \
    apt-get install -y \
    -o APT::Install-Recommend=false -o APT::Install-Suggests=false \
    python python-virtualenv libpython2.7 python-mysqldb

# Create virtual environment
# Upgrade PIP in virtual environment to latest version
# we are not using the source commands because we are using the bourn shell and not bash. bash is not used to build  docker images

RUN virtualenv /appenv && \
    . /appenv/bin/activate && \
    pip install pip --upgrade


# Add entrypoint script 
# why folder /usr/local/bin/ because this bydefault added to PATH
ADD scripts/entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]

LABEL application=todobackend