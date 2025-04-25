#!/bin/bash

# Load environment variables from .env file
if [ -f .env ]; then
  export $(grep -v '^#' .env | xargs)
  echo "Loaded environment variables from .env file"
else
  echo "No .env file found, using default values"
fi

# Set default values for required variables
APP_NAME=${APP_NAME:-"SwiftUIViperApp"}
BUNDLE_ID_PREFIX=${BUNDLE_ID_PREFIX:-"com.example"}
TEAM_ID=${TEAM_ID:-""}
APP_GROUP_ID=${APP_GROUP_ID:-"group.com.example.swiftuiviperapp"}

echo "Generating project.yml with:"
echo "  - App Name: $APP_NAME"
echo "  - Bundle ID Prefix: $BUNDLE_ID_PREFIX"
echo "  - Team ID: $TEAM_ID"

# Replace environment variables in template
cat project.yml.template | \
  sed "s/\${APP_NAME}/$APP_NAME/g" | \
  sed "s/\${BUNDLE_ID_PREFIX}/$BUNDLE_ID_PREFIX/g" | \
  sed "s/\${TEAM_ID}/$TEAM_ID/g" > project.yml

# Make sure XcodeGen is installed
if ! command -v xcodegen &> /dev/null; then
  echo "XcodeGen not found, installing with Homebrew..."
  if ! command -v brew &> /dev/null; then
    echo "Homebrew not found. Please install Homebrew first: https://brew.sh/"
    exit 1
  fi
  brew install xcodegen
fi

# Generate Xcode project
echo "Generating Xcode project..."
xcodegen

echo "Project $APP_NAME.xcodeproj generated successfully!"
