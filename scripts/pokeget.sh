#!/usr/bin/env bash

set -euo pipefail

# ==============================================================================
# pokeget
# ==============================================================================

VERSION="1.6.7"
APP_DIR="$HOME/Apps"
APP_NAME="pokeget"

BASE_URL="https://github.com/talwat/pokeget-rs/releases/download/${VERSION}"

# ------------------------------------------------------------------------------
# Detect architecture
# ------------------------------------------------------------------------------

case "$(uname -m)" in
    x86_64)
        ARCH="x86_64"
        ;;
    aarch64)
        ARCH="aarch64"
        ;;
    *)
        echo "Unsupported architecture: $(uname -m)"
        exit 1
        ;;
esac

# ------------------------------------------------------------------------------
# Download
# ------------------------------------------------------------------------------

mkdir -p "$APP_DIR"

URL="${BASE_URL}/pokeget-${ARCH}-unknown-linux-gnu"

echo "Downloading pokeget ${VERSION}..."
curl -fL "$URL" -o "$APP_DIR/$APP_NAME"

# ------------------------------------------------------------------------------
# Make executable
# ------------------------------------------------------------------------------

chmod +x "$APP_DIR/$APP_NAME"

echo "Installed: $APP_DIR/$APP_NAME"
echo "Version:   $VERSION"

