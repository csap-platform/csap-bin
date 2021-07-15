#!/bin/bash

#
#  source: https://wiki.openjdk.java.net/display/JDKUpdates/JDK11u
#

source ~/.bashrc

# Run via:
# externalDeploy <version> <file>
#
# externalDeploy.sh 11.0.1 ~/stuff/myFile.tar.gz
#  OpenJDK11U-jdk_x64_linux_11.0.4_11.tar.gz
#  versus  jdk-11.0.3_linux-x64_bin.tar.gz

# /csap-package-java-secondary/OpenJDK11U-jdk_x64_linux_11.0.5_10.tar.gz

#mavenArtifactVersion=${1:-11.0.5_10} ;
#pathToJavaBinary=${2:-$HOME/OpenJDK11U-jdk_x64_linux_11.0.5_10.tar.gz} ;
mavenArtifactVersion=${1:-11.0.8_10} ;
pathToJavaBinary=${2:-$HOME/OpenJDK11U-jdk_x64_linux_11.0.8_10.tar.gz} ;
mavenSettingsFile="$STAGING/conf/resources/settings.xml"

windowsBashFolder="/mnt/d/downloads" ;
if [ -d $windowsBashFolder ] ; then
	pathToJavaBinary=${2:-$windowsBashFolder/OpenJDK11U-jdk_x64_linux_11.0.8_10.tar.gz} ;
	mavenSettingsFile="/mnt/c/Users/peter.nightingale/.m2/settings.xml"
	echo "Found windowsBashFolder: '$windowsBashFolder' mavenSettingsFile: '$mavenSettingsFile'"
fi

echo "pathToJavaBinary: '$pathToJavaBinary' mavenArtifactVersion: '$mavenArtifactVersion'" ;

GROUP_ID="bin"
ARTIFACT_ID="jdk"
TYPE="tar.gz"
REPO_ID="csap-release-repo"
REPO_URL="http://devops-prod01.lab.sensus.net:8081/artifactory/csap-release/"
#REPO_ID="csap-snapshot-repo"
#REPO_URL="http://moc-artifactory.lab.sensus.net/artifactory/csap-snapshots/"

#exit ;



mvn --batch-mode --settings $mavenSettingsFile deploy:deploy-file \
  -DgroupId=$GROUP_ID \
  -DartifactId=$ARTIFACT_ID \
  -Dversion=$mavenArtifactVersion \
  -Dpackaging=$TYPE \
  -Dfile=$pathToJavaBinary \
  -DrepositoryId=$REPO_ID \
  -Durl=$REPO_URL

