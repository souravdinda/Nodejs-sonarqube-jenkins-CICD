!#/bin/bash
apt-get update
apt-get install unzip wget nodejs

mkdir /downloads/sonarqube -p
cd /downloads/sonarqube
wget https://binaries.sonarsource.com/Distribution/sonar-scanner-cli/sonar-scanner-cli-4.2.0.1873-linux.zip
unzip sonar-scanner-cli-4.2.0.1873-linux.zip
mv sonar-scanner-4.2.0.1873-linux /opt/sonar-scanner


vi  /opt/sonar-scanner/conf/sonar-scanner.properties

sonar.host.url=http://localhost:9000
sonar.sourceEncoding=UTF-8

echo "#!/bin/bash \
export PATH="$PATH:/opt/sonar-scanner/bin" " /etc/profile.d/sonar-scanner.sh


env | grep PATH

sonar-scanner -v