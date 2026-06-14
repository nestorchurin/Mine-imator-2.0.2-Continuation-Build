#!/bin/bash
set -e

echo "=== Mine-imator Linux Flatpak Build Script ==="

# Check requirements
if ! command -v flatpak-builder &> /dev/null; then
    echo "ERROR: flatpak-builder is not installed."
    exit 1
fi

if ! command -v dotnet &> /dev/null; then
    echo "ERROR: dotnet SDK is not installed."
    exit 1
fi

# 1. Transpile GML to C++ on host
echo "--> Running CppGen GML transpiler..."
dotnet run --project CppGen/CppGen/CppGen.csproj -- "$PWD/GmProject" "$PWD/CppProject/Generated" "$PWD/CppProject/Asset/Sprites" "$PWD/CppProject/Asset/Shaders" "$PWD/CppGen/gml.json"

# 2. Build and install Flatpak locally
echo "--> Building Flatpak..."
flatpak-builder --force-clean --user --install --ccache build-dir com.nestor_churin.MineImator.local.yml

echo "=== Build and installation completed successfully! ==="
echo "You can now run: flatpak run com.nestor_churin.MineImator"
