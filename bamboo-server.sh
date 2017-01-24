#!/usr/bin/env bash

set -e # Exit on errors

echo "-> Starting Bamboo Agent ..."
echo "   - BAMBOO_VERSION: $BAMBOO_VERSION"
echo "   - BAMBOO_HOME:    $BAMBOO_HOME"

mkdir -p $BAMBOO_HOME

BAMBOO_DIR=/opt/atlassian-bamboo-$BAMBOO_VERSION

if [ -d $BAMBOO_DIR ]; then
  echo "-> Bamboo $BAMBOO_VERSION already found at $BAMBOO_DIR. Skipping download."
else
  BAMBOO_TARBALL_URL=http://downloads.atlassian.com/software/bamboo/downloads/atlassian-bamboo-$BAMBOO_VERSION.tar.gz
  MYSQLDRIVER_TARBALL_URL=https://dev.mysql.com/get/Downloads/Connector-J/mysql-connector-java-5.1.40.tar.gz
  echo "-> Downloading Bamboo $BAMBOO_VERSION from $BAMBOO_TARBALL_URL ..."
  wget --progress=dot:mega $BAMBOO_TARBALL_URL -O /tmp/atlassian-bamboo.tar.gz
  echo "-> Downloading MySQL driver from $MYSQLDRIVER_TARBALL_URL ..."
  wget --progress=dot:mega $MYSQLDRIVER_TARBALL_URL -O /tmp/mysql-connector-java.tar.gz
  echo "-> Extracting to $BAMBOO_DIR ..."
  tar xzf /tmp/atlassian-bamboo.tar.gz -C /opt
  rm -f /tmp/atlassian-bamboo.tar.gz
  echo "-> Adding MySQL driver"
  tar zxvf /tmp/mysql-connector-java.tar.gz -C $BAMBOO_DIR/lib/ --strip-components 1 ./mysql-connector-java-5.1.40/mysql-connector-java-5.1.40-bin.jar
  rm -f /tmp/mysql-connector-java.tar.gz
  echo "-> Installation completed"
fi

echo "-> Running Bamboo server ..."
$BAMBOO_DIR/bin/catalina.sh run
