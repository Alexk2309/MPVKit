#!/bin/bash
set -e

# Upload MPVKit.xcframework.zip to a GitHub release.
# Just uploads — does not rebuild anything.
#
# Usage:
#   ./scripts/upload-framework.sh                 # uses default tag below
#   ./scripts/upload-framework.sh 0.41.0-av       # override tag

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"

# GitHub release settings (must match the URL in Package.swift)
GITHUB_REPO="mpv-ios/MPVKit"
GITHUB_TAG="${1:-0.41.0-av}"
RELEASE_ZIP_NAME="MPVKit.xcframework.zip"

# Source zip location (produced by create-combined-framework.sh)
SOURCE_ZIP="$PROJECT_ROOT/dist/MPVKit-combined/MPVKit.xcframework.zip"

echo "=============================================="
echo "  Uploading to GitHub Release"
echo "=============================================="
echo "  Repo:   $GITHUB_REPO"
echo "  Tag:    $GITHUB_TAG"
echo "  Asset:  $RELEASE_ZIP_NAME"
echo "  Source: $SOURCE_ZIP"
echo ""

# Check source exists
if [ ! -f "$SOURCE_ZIP" ]; then
    echo "❌ Source zip not found: $SOURCE_ZIP"
    echo "   Run './Sources/BuildScripts/create-combined-framework.sh' first"
    exit 1
fi

ls -lh "$SOURCE_ZIP"
echo ""

# Delete existing asset if present (ignore errors)
echo "🗑️  Removing old asset (if exists)..."
gh release delete-asset "$GITHUB_TAG" "$RELEASE_ZIP_NAME" --repo "$GITHUB_REPO" --yes 2>/dev/null || true

# Upload new asset (asset name on the release will match the source filename)
echo "🚀 Uploading new asset..."
gh release upload "$GITHUB_TAG" "$SOURCE_ZIP" --repo "$GITHUB_REPO"

echo ""
echo "✅ Uploaded to: https://github.com/$GITHUB_REPO/releases/tag/$GITHUB_TAG"
echo ""
echo "📌 In your other project, refresh the Swift Package dependency to pull the new version."
