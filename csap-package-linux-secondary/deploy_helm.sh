#!/bin/bash

#
#  vcgo:  https://github.com/helm/helm/releases
#
# Run via:
# externalDeploy <version> <file>
#
# externalDeploy.sh 11.0.1 ~/stuff/myFile.tar.gz

VERSION=${1:-3.7.0}
sourceFile=${2:-$CSAP_FOLDER/bin/helm}
mavenUploadFile=${2:-$(pwd)/helm.gz}

gzip -c $sourceFile > $mavenUploadFile

GROUP_ID="bin"
ARTIFACT_ID="helm"
TYPE="gz"

REPO_ID="csap-release-repo"
REPO_URL="http://devops-prod01.lab.sensus.net:8081/artifactory/csap-release/"


# Note: this will require version to have SNAPSHOT APPENDED
# VERSION="$VERSION-SNAPSHOT"
# REPO_ID="csap-snapshot-repo"
# REPO_URL="http://devops-prod01.lab.sensus.net:8081/artifactory/csap-snapshots"

#mavenSettingsFile="$CSAP_FOLDER/definition/resources/settings.xml"
mavenSettingsFile="$csapDefinitionResources/settings.xml"

#
# --no-transfer-progress 
#
mvn -s $mavenSettingsFile deploy:deploy-file \
  -DgroupId=$GROUP_ID \
  -DartifactId=$ARTIFACT_ID \
  -Dversion=$VERSION \
  -Dpackaging=$TYPE \
  -Dfile=$mavenUploadFile \
  -DrepositoryId=$REPO_ID \
  -Durl=$REPO_URL
