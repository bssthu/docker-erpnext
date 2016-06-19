FROM ubuntu:14.04

MAINTAINER bssthu

# Install Deps
RUN apt-get update && \
    apt-get install -y --no-install-recommends wget npm supervisor && \
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
    bash /opt/tools/setup_frappe.sh --setup-production

# Other Envs
VOLUME ["/var/lib/mysql", "/home/frappe/frappe-bench/sites/site1.local/"]

COPY tools/all.conf /etc/supervisor/conf.d/
EXPOSE 80
CMD ["/usr/bin/supervisord", "-n"]

