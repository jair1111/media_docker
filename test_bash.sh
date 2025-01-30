#!/bin/bash

# Check if a directory argument is provided
if [ -z "$1" ]; then
    echo "Usage: $0 <directory>"
    exit 1
fi

# Ensure the provided argument is a valid directory
if [ ! -d "$1" ]; then
    echo "Error: '$1' is not a directory."
    exit 1
fi

# Define zip storage, source, pages, and build directories
source_dir="docs/source"
zip_dir="zips"
pages_dir="docs/source/pages"
build_dir="docs/build"

# Create zip storage, source, pages, and build directories if they don't exist
mkdir -p "$source_dir"
mkdir -p "$source_dir/$zip_dir"
mkdir -p "$pages_dir"
mkdir -p "$build_dir"

# List subdirectories only and process them
for dir in "$1"/*/; do
    if [ -d "$dir" ]; then
        subdir_name="$(basename "$dir")"
        echo "$subdir_name"
        (cd "$1" && zip -r "../$source_dir/$zip_dir/$subdir_name.zip" "$subdir_name")

        # Check for README.rst and copy if exists
        if [ -f "$dir/README.rst" ]; then
            cp "$dir/README.rst" "$pages_dir/$subdir_name.rst"
            echo ":download:\`Download flow <../$zip_dir/$subdir_name.zip>\`." >> "$pages_dir/$subdir_name.rst"
        else
            echo "Error: README.rst not found in $subdir_name"
            exit 1
        fi
    fi
done

# Run Sphinx build
sphinx-build -W -a -b html "$source_dir" "$build_dir"
