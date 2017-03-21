FROM eledge/ubuntu-openjdk8:latest

# Environment for Bamboo
ENV BAMBOO_VERSION=5.15.3 \
  BAMBOO_HOME=/home/bamboo

# Expose ports (web/agent)
EXPOSE 8085 54663

ADD bamboo-server.sh /usr/local/bin/bamboo-server.sh

RUN apt-get update \
  && apt-get install  --no-install-recommends --no-install-suggests -yq software-properties-common python-software-properties \
  && apt-get install --no-install-recommends --no-install-suggests -yq git maven ssh \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* \
  && chmod +x /usr/local/bin/bamboo-server.sh

CMD ["/usr/local/bin/bamboo-server.sh"]
