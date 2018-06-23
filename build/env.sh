#!/bin/sh

set -e

if [ ! -f "build/env.sh" ]; then
    echo "$0 must be run from the root of the repository."
    exit 2
fi

# Create fake Go workspace if it doesn't exist yet.
workspace="$PWD/build/_workspace"
root="$PWD"
cwnetdir="$workspace/src/github.com/cwnet"
if [ ! -L "$cwnetdir/go-cwnet" ]; then
    mkdir -p "$cwnetdir"
    cd "$cwnetdir"
    ln -s ../../../../../. go-cwnet
    cd "$root"
fi

# Set up the environment to use the workspace.
GOPATH="$workspace"
export GOPATH

# Run the command inside the workspace.
cd "$cwnetdir/go-cwnet"
PWD="$cwnetdir/go-cwnet"

# Launch the arguments with the configured environment.
exec "$@"
