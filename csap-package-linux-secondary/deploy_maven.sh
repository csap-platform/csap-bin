#!/bin/bash

# Run via:
# externalDeploy <version> <file>
#
# externalDeploy.sh 11.0.1 ~/stuff/myFile.tar.gz

VERSION=${1:-3.6.1}
FILE=${2:-apache-maven-3.6.1-bin.zip}

GROUP_ID="bin"
ARTIFACT_ID="maven"
TYPE="zip"

REPO_ID="csap-release-repo"
REPO_URL="http://devops-prod01.lab.sensus.net:8081/artifactory/csap-release/"

# Note: this will require version to have SNAPSHOT APPENDED
# VERSION="$VERSION-SNAPSHOT"
# REPO_ID="csap-snapshot-repo"
# REPO_URL="http://devops-prod01.lab.sensus.net:8081/artifactory/csap-snapshots"


mavenSettingsFile="$STAGING/conf/propertyOverride/settings.xml"

mvn -s $mavenSettingsFile deploy:deploy-file \
  -DgroupId=$GROUP_ID \
  -DartifactId=$ARTIFACT_ID \
  -Dversion=$VERSION \
  -Dpackaging=$TYPE \
  -Dfile=$FILE \
  -DrepositoryId=$REPO_ID \
  -Durl=$REPO_URL
