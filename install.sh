#!/usr/bin/env bash
# Bootstraps a fresh machine with the Hugo binary used by this site.
# Supports macOS and Linux.

set -euo pipefail

if [ $(id -u) -ne 0 ]; then
  echo "**********************************************"
  echo "Please run this script as root or use sudo!"
  echo "This is required to copy the hugo executable"
  echo "into the /usr/local/bin folder"
  echo "**********************************************"
  exit 0
fi

hash wget 2>/dev/null || { echo "'wget' is not installed but is required by this script." >&2; exit 1; }

HUGO_VERSION=0.134.2

install_hugo( ) {
  VERSION="$1"

  INSTALL_PATH=/usr/local/bin
  HUGO_BIN="${INSTALL_PATH}/hugo"

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

  echo "Installing Hugo v${HUGO_VERSION}..."

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

  cd "${WORKING_DIRECTORY}"
  rm -rf "${TEMP_DIR}"

  if [ ${HUGO_OS_ARCH} == 'darwin-universal' ]; then
      xattr -dr com.apple.quarantine ${HUGO_BIN}
  fi

  hugo version
}

echo "Checking for Hugo installation..."
if hash hugo 2>/dev/null; then
  if grep -q "hugo v${HUGO_VERSION}" <<< $(hugo env); then
    echo "Detected Hugo v${HUGO_VERSION}. Nothing to do."
  else
    echo "Hugo present but not v${HUGO_VERSION}. Installing target version..."
    install_hugo $HUGO_VERSION
  fi
else
  echo "Hugo not installed."
  install_hugo $HUGO_VERSION
fi

echo "Install complete. Next: run 'npm install' in the project to pull Wrangler, then './start.sh'."
