#!/usr/bin/env bash

# Ensure correct local path.
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
cd $SCRIPT_DIR

# Add dotnet non-admin-install to path
export PATH=~/.dotnet:$PATH

# Building first is more reliable than running directly from src
dotnet build src/StableSwarmUI.csproj --configuration Release -o ./src/bin/live_release
# Default env configuration, gets overwritten by the C# code's settings handler
export ASPNETCORE_ENVIRONMENT="Production"
export ASPNETCORE_URLS="http://*:7801"
# Actual runner.
dotnet src/bin/live_release/StableSwarmUI.dll $@
