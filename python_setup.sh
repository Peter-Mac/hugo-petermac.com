#!/usr/bin/env bash
set -euo pipefail

# Go to the directory this script is in
cd "$(dirname "$0")"

ENV_NAME="hugoenv"
REQ_FILE="requirements.txt"

echo "🔧 Checking Python environment..."

# Create virtual environment if not exists
if [ ! -d "$ENV_NAME" ]; then
  echo "📦 Creating Python virtual environment: $ENV_NAME"
  python3 -m venv "$ENV_NAME"
else
  echo "✅ Python virtual environment '$ENV_NAME' already exists."
fi

# Create requirements.txt if not exists
if [ ! -f "$REQ_FILE" ]; then
  echo "📝 Creating default requirements.txt with pagefind"
  echo "pagefind" > "$REQ_FILE"
fi

# Activate environment and install requirements
echo "📥 Installing requirements from $REQ_FILE"
. "$ENV_NAME/bin/activate"
pip install --upgrade pip
pip install -r "$REQ_FILE"

echo "✅ Python setup complete."
