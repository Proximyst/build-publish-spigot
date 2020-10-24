#!/bin/sh

rm -rf ./.git
apt-get update
apt-get install -qy wget
echo "$MVN_SETTINGS" > mvn-settings.xml
wget https://hub.spigotmc.org/jenkins/job/BuildTools/lastSuccessfulBuild/artifact/target/BuildTools.jar
java -jar BuildTools.jar --rev 1.16.3
mvn deploy:deploy-file \
    -s ./mvn-settings.xml \
    -DgroupId=org.spigotmc \
    -DartifactId=spigot \
    -Dversion=1.16.3-R0.1-SNAPSHOT \
    -Dpackaging=jar \
    -Dfile=spigot-1.16.3.jar \
    -DrepositoryId=proxi-nexus \
    -Durl=https://nexus.proximyst.com/repository/maven-any/
