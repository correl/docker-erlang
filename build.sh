#!/bin/bash
set -e

repository=correl/erlang
versions=( */ )

for version in "${versions[@]%/}"; do
    echo "Building ${version}..."
    docker build -t ${repository}:${version} ${version}
done
