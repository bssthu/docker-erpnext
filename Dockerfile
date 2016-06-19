FROM ubuntu:14.04

MAINTAINER bssthu

COPY tools /opt/tools

# Create user
RUN adduser --disabled-password --gecos '' frappe && \
    adduser frappe sudo && \
    echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

WORKDIR /home/frappe

# Install deps and bench
RUN apt-get update && \
    apt-get install -y --no-install-recommends wget npm supervisor && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* && \
    bash /opt/tools/install.sh && \
    rm *.deb && \
    apt-get -y -q remove build-essential python-dev && \
    apt-get -y -q autoremove

# Other envs
VOLUME ["/var/lib/mysql", "/home/frappe/frappe-bench/sites/site1.local/"]

COPY tools/all.conf /etc/supervisor/conf.d/
EXPOSE 80
CMD ["/usr/bin/supervisord", "-n"]

