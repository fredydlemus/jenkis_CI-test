# Depending on your system you might need to use sudo
adduser jenkins
apt-get update
apt-get install openjdk-8-jdk wget gnupg git vim
mkdir /jenkins
chown -R jenkins:jenkins /jenkins