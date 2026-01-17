#!/bin/bash
set -e

TOMCAT_VER=9.0.113
TOMCAT_DIR=/opt/apache-tomcat-$TOMCAT_VER

echo "Installing dependencies..."
sudo apt-get update
sudo apt-get install -y default-jdk wget unzip git

echo "Cleaning old Tomcat..."
sudo rm -rf /opt/apache-tomcat-9*

cd /opt

echo "Downloading Tomcat $TOMCAT_VER..."
sudo wget -q https://dlcdn.apache.org/tomcat/tomcat-9/v$TOMCAT_VER/bin/apache-tomcat-$TOMCAT_VER.zip

echo "Extracting Tomcat..."
sudo unzip -q apache-tomcat-$TOMCAT_VER.zip
sudo rm -f apache-tomcat-$TOMCAT_VER.zip

echo "Cloning config repo..."
sudo git clone https://github.com/adhig93/tomcat-config

echo "Applying configuration..."
sudo cp tomcat-config/context.xml $TOMCAT_DIR/webapps/manager/META-INF/context.xml
sudo cp tomcat-config/context.xml $TOMCAT_DIR/webapps/host-manager/META-INF/context.xml
sudo cp tomcat-config/tomcat-users.xml $TOMCAT_DIR/conf/tomcat-users.xml

sudo rm -rf tomcat-config

echo "Starting Tomcat..."
cd $TOMCAT_DIR
sudo sh bin/startup.sh

echo "Tomcat started successfully"
