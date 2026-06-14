#!/bin/bash
set -e

echo "=== Mine-imator Linux Flatpak Release Bundle Builder ==="

# Check requirements
if ! command -v flatpak-builder &> /dev/null; then
    echo "ERROR: flatpak-builder is not installed."
    exit 1
fi

# We build from the production manifest com.nestor_churin.MineImator.yml
# which pulls from the GitHub repository to guarantee build repeatability.
MANIFEST="com.nestor_churin.MineImator.yml"

echo "--> Building Flatpak from manifest: $MANIFEST..."
flatpak-builder --force-clean --repo=repo build-dir "$MANIFEST"

echo "--> Generating standalone .flatpak bundle..."
flatpak build-bundle repo com.nestor_churin.MineImator.flatpak com.nestor_churin.MineImator

echo "=== Standalone bundle created successfully! ==="
echo "File created: com.nestor_churin.MineImator.flatpak"
echo "You can install it locally using:"
echo "  flatpak install --user com.nestor_churin.MineImator.flatpak"
