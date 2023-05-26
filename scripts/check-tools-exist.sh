#!/bin/bash
set -e

for var in "$@"
do
    tool=$(echo $var | cut -d "@" -f 1)

    echo "Check $tool exists"
    docker run -v $(pwd)/scripts:/scripts --entrypoint bash $DOCKER_IMAGE /scripts/check-tool.sh $tool

    if [[ $var =~ @ ]]
    then
        version=$(echo $var | cut -d "@" -f 2)
        echo "Check $tool is using version $version"
        docker run -v $(pwd)/scripts:/scripts --entrypoint bash $DOCKER_IMAGE /scripts/check-version.sh $tool $version
    fi
    
done