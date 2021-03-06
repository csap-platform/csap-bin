#!/bin/bash

#
#  source: https://wiki.openjdk.java.net/display/JDKUpdates/JDK11u
#

source ~/.bashrc

# Run via:
# externalDeploy <version> <file>
#


function print_section() { 
	echo -e  "\n* \n**\n*** \n**** \n*****  $* \n**** \n*** \n** \n*"
}

#wget https://github.com/AdoptOpenJDK/openjdk11-upstream-binaries/releases/download/jdk-11.0.12%2B7/OpenJDK11U-jdk_x64_linux_11.0.12_7.tar.gz

if test -d /mnt/CSAP_DEV01_NFS/csap-web-server/java; then
	wget https://github.com/AdoptOpenJDK/openjdk11-upstream-binaries/releases/download/jdk-11.0.13%2B8/OpenJDK11U-jdk_x64_linux_11.0.13_8.tar.gz
fi ;


#
#  linux settings
#
mavenSettingsFile="$csapDefinitionResources/settings.xml"
#mavenArtifactVersion=${1:-11.0.13_8} ;
mavenArtifactVersion=${1:-17.0.2} ;
#pathToJavaBinary=${2:-/mnt/CSAP_DEV01_NFS/csap-web-server/java/OpenJDK11U-jdk_x64_linux_$mavenArtifactVersion.tar.gz} ;;
pathToJavaBinary=${2:-/mnt/CSAP_DEV01_NFS/csap-web-server/java/openjdk-$mavenArtifactVersion\_linux-x64_bin.tar.gz} ;

#openjdk-17.0.2_linux-x64_bin.tar.gz


#
# Windows bash shell on eclipse settings
#

windowsBashFolder="/mnt/d/downloads" ;

if test -d $windowsBashFolder ; then
	pathToJavaBinary=${2:-$windowsBashFolder/$(basename $pathToJavaBinary)} ;
	mavenSettingsFile="/mnt/c/Users/peter.nightingale/.m2/settings.xml"
	echo "Found windowsBashFolder: '$windowsBashFolder' mavenSettingsFile: '$mavenSettingsFile'"
fi

print_section "pathToJavaBinary: '$pathToJavaBinary' mavenArtifactVersion: '$mavenArtifactVersion'" ;

if test -f $pathToJavaBinary ; then

	GROUP_ID="bin"
	ARTIFACT_ID="jdk"
	TYPE="tar.gz"
	REPO_ID="csap-release-repo"
	REPO_URL="http://devops-prod01.lab.sensus.net:8081/artifactory/csap-release/"
	#REPO_ID="csap-snapshot-repo"
	#REPO_URL="http://moc-artifactory.lab.sensus.net/artifactory/csap-snapshots/"
	
	#exit ;
	
	print_section "Uploading artifact $ARTIFACT_ID to maven: $REPO_URL"
	
	mvn --batch-mode --settings $mavenSettingsFile deploy:deploy-file \
	  -DgroupId=$GROUP_ID \
	  -DartifactId=$ARTIFACT_ID \
	  -Dversion=$mavenArtifactVersion \
	  -Dpackaging=$TYPE \
	  -Dfile=$pathToJavaBinary \
	  -DrepositoryId=$REPO_ID \
	  -Durl=$REPO_URL

else 
	print_section "Verify binary location: $pathToJavaBinary"
fi ;
