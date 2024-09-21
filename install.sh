#!/usr/bin/env bash

# Used for both Linux and MacOS installations

set -euo pipefail

if [ $(id -u) -ne 0 ]; then
  echo "**********************************************"
  echo "Please run this script as root or use sudo!"
  echo "This is required to copy the hugo executable"
  echo "into the /usr/local/bin folder"
  echo "**********************************************"
  exit 0
fi

# Assert that wget is installed
hash wget 2>/dev/null || { echo "'wget' is not installed but is required by this script." >&2; exit 1; }

HUGO_VERSION=0.134.2

# The main installation function
install_hugo( ) {
VERSION="$1"

# PATH applies for both linux and MacOS
INSTALL_PATH=/usr/local/bin
HUGO_BIN="${INSTALL_PATH}/hugo"

HUGO_ARCH_OS="darwin-universal"
# ^^^ choices for 'HUGO_OS_ARCH' (Extended Version only):
# - 'darwin-universal' (macOS Universal Binary, Hugo 0.102.0 and up)
# - 'linux-amd64' (Linux/WSL on x86-64)
# - 'linux-arm64' (Linux/WSL on ARM-64)

if [ "$(uname)" == "Darwin" ]; then
  echo "Detected platform: Darwin."
  HUGO_OS_ARCH="darwin-universal"
elif [ "$(expr substr $(uname -s) 1 5)" == "Linux" ]; then
  echo "Detected platform: Linux."
  HUGO_OS_ARCH="linux-amd64"
else
  echo "Unsupported platform: $(uname)" >&2
  exit 1
fi

# Assert that required variables are now set
if [ -z ${HUGO_OS_ARCH:-} ]; then
  echo HUGO_OS_ARCH was not set >&2
  exit 1
fi

echo "Failed to detect Hugo v.${HUGO_VERSION} --- installing it..."

# https://github.com/gohugoio/hugo/releases/
# Save the current working directory as we may have to cd out of it
# and want to ensure we end in the same place.
WORKING_DIRECTORY=$(pwd)

TEMP_DIR=$(mktemp -d 2>/dev/null || mktemp -d -t 'mytmpdir')

TAR_NAME="hugo_extended_${HUGO_VERSION}_${HUGO_OS_ARCH}.tar.gz"
DOWNLOAD_URL="https://github.com/gohugoio/hugo/releases/download/v${HUGO_VERSION}/${TAR_NAME}"

echo "Downloading hugo from ${DOWNLOAD_URL}..."
wget -P "${TEMP_DIR}" "${DOWNLOAD_URL}"

cd "${TEMP_DIR}"

echo "Extracting ${TAR_NAME}..."
tar -xzvf ${TAR_NAME}

echo "Moving Hugo..."
mv hugo "${HUGO_BIN}"

echo "Hugo binary is: ${HUGO_BIN}"

# Return to the old directory
cd "${WORKING_DIRECTORY}"

rm -rf "${TEMP_DIR}"

if [ ${HUGO_OS_ARCH} == 'darwin-universal' ]; then
    xattr -dr com.apple.quarantine ${HUGO_BIN}  # "bless" the Hugo binary in macOS
fi
hugo version
exit 0

}
echo "Checking for installation..."

if hash hugo 2>/dev/null; then
  if grep -q "hugo v${HUGO_VERSION}" <<< $(hugo env); then
    echo "Detected Hugo v.${HUGO_VERSION}!"
    echo "Nothing to do...quitting"
  else
    echo "Failed to detect Hugo v.${HUGO_VERSION} --- installing it..."
    install_hugo $HUGO_VERSION
  fi
else
  echo "Hugo not installed..."
  install_hugo $HUGO_VERSION
fi

# end

