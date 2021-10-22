#!/bin/bash

#
#  source: https://wiki.openjdk.java.net/display/JDKUpdates/JDK11u
#

source ~/.bashrc

# Run via:
# externalDeploy <version> <file>
#



wget https://github.com/AdoptOpenJDK/openjdk11-upstream-binaries/releases/download/jdk-11.0.12%2B7/OpenJDK11U-jdk_x64_linux_11.0.12_7.tar.gz
#
#  linux settings
#
mavenSettingsFile="$csapDefinitionResources/settings.xml"
mavenArtifactVersion=${1:-11.0.12_7} ;
pathToJavaBinary=${2:-/mnt/CSAP_DEV01_NFS/csap-web-server/java/OpenJDK11U-jdk_x64_linux_$mavenArtifactVersion.tar.gz} ;
# mavenArtifactVersion=${1:-11.0.11_9} ;
# pathToJavaBinary=${2:-$HOME/OpenJDK11U-jdk_x64_linux_11.0.11_9.tar.gz} ;



#
# Windows bash shell on eclipse settings
#

windowsBashFolder="/mnt/d/downloads" ;
#if test -d "/d/downloads" ; then
#	windowsBashFolder="/d/downloads" ;
#fi ;
if test -d $windowsBashFolder ; then
	pathToJavaBinary=${2:-$windowsBashFolder/$(basename $pathToJavaBinary)} ;
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

