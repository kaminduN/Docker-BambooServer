FROM openjdk:latest

# Environment for Bamboo
ENV BAMBOO_VERSION=6.0.0 \
  BAMBOO_HOME=/home/bamboo

# Expose ports (web/agent)
EXPOSE 8085 54663

# Add installation script
ADD resources/bamboo-server.sh /usr/local/bin/bamboo-server.sh

# Install additional dependencies & add execute rights to script
RUN apt-get update \
  && apt-get upgrade -yq \
  && apt-get install --no-install-recommends --no-install-suggests -yq software-properties-common python-software-properties \
  && apt-get install --no-install-recommends --no-install-suggests -yq ssh \
  && apt-get install --no-install-recommends --no-install-suggests -yq libeclipse-aether-java=1.0.2-1~bpo8+1 libguice-java=4.0-2~bpo8+1 libsisu-inject-java=0.3.2-1~bpo8+1 libsisu-plexus-java=0.3.2-1~bpo8+1 libmaven3-core-java=3.3.9-3~bpo8+1 maven=3.3.9-3~bpo8+1 \
  && apt-get autoremove -yq \
  && apt-get autoclean -yq \
  && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* \
  && chmod +x /usr/local/bin/bamboo-server.sh

VOLUME ["/home/bamboo","/opt/atlassian-bamboo-6.0.0/logs"]

# Run script on start up
CMD ["/usr/local/bin/bamboo-server.sh"]
