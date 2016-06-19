FROM debian:wheezy

MAINTAINER bssthu

# Install Deps
RUN echo "deb http://http.debian.net/debian wheezy-backports main" >> /etc/apt/sources.list && \
    apt-get update && \
    apt-get install -y sudo wget supervisor adduser && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

COPY tools /opt/tools

# Create User
RUN adduser --disabled-password --gecos '' frappe && \
    adduser frappe sudo && \
    echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

WORKDIR /home/frappe

# Install bench
RUN supervisord && \
    bash /opt/tools/setup_frappe.sh --setup-production && \
    apt-get remove -y -q build-essential python-dev && \
    apt-get autoremove

# Other Envs
VOLUME ["/var/lib/mysql", "/home/frappe/frappe-bench/sites/site1.local/"]

COPY tools/all.conf /etc/supervisor/conf.d/
EXPOSE 80
CMD ["/usr/bin/supervisord", "-n"]

