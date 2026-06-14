#!/bin/bash
set -e

echo "=== Mine-imator Linux Native Build Script ==="

if ! command -v dotnet &> /dev/null; then
    echo "ERROR: dotnet SDK is not installed."
    exit 1
fi

if ! command -v cmake &> /dev/null; then
    echo "ERROR: cmake is not installed."
    exit 1
fi

# 1. Transpile GML to C++ on host
echo "--> Running CppGen GML transpiler..."
dotnet run --project CppGen/CppGen/CppGen.csproj -- "$PWD/GmProject" "$PWD/CppProject/Generated" "$PWD/CppProject/Asset/Sprites" "$PWD/CppProject/Asset/Shaders" "$PWD/CppGen/gml.json"

# 2. Build natively
echo "--> Compiling CppProject..."
mkdir -p CppProject/build
cd CppProject/build
cmake -DUSE_SYSTEM_LIBS=ON -DCMAKE_BUILD_TYPE=Release ..
make -j$(nproc)

echo "=== Native build completed successfully! ==="
echo "Binary location: CppProject/build/Mine-imator"
