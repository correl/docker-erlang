#!/bin/bash
set -e

cd "$(dirname "$(readlink -f "$BASH_SOURCE")")"

versions=( */ )

otp_versions() {
    curl -sSL --compressed "http://www.erlang.org/download/MD5" \
        | grep 'otp_src_.*\.tar.gz' \
        | sed -r 's#.*\(otp_src_(.*?)\.tar\.gz\).*#\1#' \
        | sort -rV
}

git_releases() {
    curl -sSL --compressed "https://api.github.com/repos/$1/releases" \
        | grep "tag_name" \
        | sed -r 's#.*: "([^"]+)",$#\1#'
}

latest() {
    grep "^$1" | head -1
}

REBAR_VERSION=$(git_releases "rebar/rebar" | latest)
RELX_VERSION=$(git_releases "erlware/relx" | latest)

echo "Using rebar @ ${REBAR_VERSION}"
echo "Using relx @ ${RELX_VERSION}"
echo

for version in "${versions[@]%/}"; do
    OTP_VERSION=$(otp_versions | latest $version)
    echo "Using OTP ${version} @ ${OTP_VERSION}"
    sed -ri 's#^(ENV OTP_VERSION) .*#\1 '"${OTP_VERSION}"'#' "${version}/Dockerfile"
    sed -ri 's#^(ENV REBAR_VERSION) .*#\1 '"${REBAR_VERSION}"'#' "${version}/Dockerfile"
    sed -ri 's#^(ENV RELX_VERSION) .*#\1 '"${RELX_VERSION}"'#' "${version}/Dockerfile"
done
