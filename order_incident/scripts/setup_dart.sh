#!/usr/bin/env bash
set -euo pipefail
if command -v dart >/dev/null 2>&1; then dart --version; exit 0; fi
mkdir -p "$HOME/.local/opt" "$HOME/.local/bin"
curl -fL --retry 3 https://storage.googleapis.com/dart-archive/channels/stable/release/latest/sdk/dartsdk-linux-x64-release.zip -o /tmp/dart-sdk.zip
python3 -c 'import zipfile,os;zipfile.ZipFile("/tmp/dart-sdk.zip").extractall(os.path.expanduser("~/.local/opt"))'
ln -sf "$HOME/.local/opt/dart-sdk/bin/dart" "$HOME/.local/bin/dart"
echo 'export PATH="$HOME/.local/bin:$PATH"' >> "$HOME/.bashrc"
"$HOME/.local/bin/dart" --version
