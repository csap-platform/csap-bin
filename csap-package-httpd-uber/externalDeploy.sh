#!/bin/bash

# Run via:
# externalDeploy <version> <file>
#
# externalDeploy.sh 11.0.1 ~/stuff/myFile.tar.gz

VERSION=${1:-2.4.52}
FILE=${2:-httpd.zip}


GROUP_ID="bin"
ARTIFACT_ID="httpd"
TYPE="zip"
REPO_ID="csap-release-repo"
REPO_URL="http://devops-prod01.lab.sensus.net:8081/artifactory/csap-release/"
#REPO_ID="csap-snapshot-repo"
#REPO_URL="http://moc-artifactory.lab.sensus.net/artifactory/csap-snapshots/"

mavenSettingsFile="$csapDefinitionResources/settings.xml"


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


mvn -s $mavenSettingsFile deploy:deploy-file \
  -DgroupId=$GROUP_ID \
  -DartifactId=$ARTIFACT_ID \
  -Dversion=$VERSION \
  -Dpackaging=$TYPE \
  -Dfile=$FILE\
  -DrepositoryId=$REPO_ID \
  -Durl=$REPO_URL

