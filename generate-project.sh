#!/bin/bash

# Check for .env file
if [ ! -f .env ]; then
  echo "Error: .env file not found!"
  echo "Please create a .env file with required configuration values."
  echo "You can use .env.example as a template if available."
  echo "See the project README for more information on required values."
  exit 1
fi

# Load environment variables from .env file
export $(grep -v '^#' .env | xargs)
echo "Loaded environment variables from .env file"

# Check for required variables
missing_vars=false

if [ -z "$APP_NAME" ]; then
  echo "Error: APP_NAME not set in .env file"
  missing_vars=true
fi

if [ -z "$BUNDLE_ID_PREFIX" ]; then
  echo "Error: BUNDLE_ID_PREFIX not set in .env file"
  missing_vars=true
fi

if [ -z "$TEAM_ID" ]; then
  echo "Error: TEAM_ID not set in .env file"
  missing_vars=true
fi

# Note: APP_GROUP_ID is now optional, no longer checked as required

if [ "$missing_vars" = true ]; then
  echo "Please update your .env file with all required variables and try again."
  exit 1
fi

echo "Generating project.yml with:"
echo "  - App Name: $APP_NAME"
echo "  - Bundle ID Prefix: $BUNDLE_ID_PREFIX"
echo "  - Team ID: $TEAM_ID"

# App Group is optional
if [ -n "$APP_GROUP_ID" ]; then
  echo "  - App Group ID: $APP_GROUP_ID"

  # Validate APP_GROUP_ID format
  if [[ "$APP_GROUP_ID" != group.* ]]; then
    echo "Warning: APP_GROUP_ID does not start with 'group.'. Double-check your .env file."
  fi
else
  echo "  - App Group ID: Not configured (skipping entitlements)"
fi

# Replace environment variables in template
cat project.yml.template | \
  sed "s/\${APP_NAME}/$APP_NAME/g" | \
  sed "s/\${BUNDLE_ID_PREFIX}/$BUNDLE_ID_PREFIX/g" | \
  sed "s/\${TEAM_ID}/$TEAM_ID/g" > project.yml

# Handle entitlements based on APP_GROUP_ID
if [ -n "$APP_GROUP_ID" ]; then
  echo "Adding app group entitlements..."

  # Insert CODE_SIGN_ENTITLEMENTS setting into project.yml
  sed -i '' "s/\${CODE_SIGN_ENTITLEMENTS}/CODE_SIGN_ENTITLEMENTS: Sources\/${APP_NAME}.entitlements/" project.yml

  # Create entitlements file with app group
  mkdir -p Sources
  cat <<EOF > "Sources/${APP_NAME}.entitlements"
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
  <key>com.apple.security.application-groups</key>
  <array>
    <string>${APP_GROUP_ID}</string>
  </array>
</dict>
</plist>
EOF
  echo "Created entitlements file at Sources/${APP_NAME}.entitlements"
else
  # Remove the placeholder if no app group is configured
  sed -i '' "s/\${CODE_SIGN_ENTITLEMENTS}//" project.yml
fi

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
