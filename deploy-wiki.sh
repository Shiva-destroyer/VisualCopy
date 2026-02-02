#!/bin/bash

# ================================================================
# DEPLOYMENT SCRIPT B: Push Wiki Documentation to GitHub Wiki
# ================================================================
# 
# Purpose: Deploy technical documentation to the GitHub Wiki repository
# Wiki URL: https://github.com/Shiva-destroyer/VisualCopy/wiki
# Wiki Git: https://github.com/Shiva-destroyer/VisualCopy.wiki.git
# 
# ⚠️  CRITICAL PREREQUISITES:
#   1. You MUST manually create the Wiki FIRST:
#      - Go to: https://github.com/Shiva-destroyer/VisualCopy/wiki
#      - Click "Create the first page" button
#      - Add any text and save (this initializes the Wiki Git repo)
#      - Without this step, the Wiki Git URL will return 404!
# 
#   2. Git must be installed and configured
#   3. You must have push access to the repository
#   4. SSH key or HTTPS credentials must be set up
# 
# ================================================================

set -e  # Exit on any error

echo "=========================================="
echo "  VisualCopy Wiki Deployment"
echo "=========================================="
echo ""

# Configurations
PROJECT_DIR="/home/shivansh/VisionCopy"
WIKI_STAGING_DIR="$PROJECT_DIR/wiki_staging"
TEMP_DIR="/tmp/visualcopy-wiki-deploy-$$"  # $$ = process ID for uniqueness
WIKI_REPO_URL="https://github.com/Shiva-destroyer/VisualCopy.wiki.git"

# Validate prerequisites
if [ ! -d "$WIKI_STAGING_DIR" ]; then
    echo "❌ Error: wiki_staging directory not found at $WIKI_STAGING_DIR"
    exit 1
fi

echo "⚠️  IMPORTANT: Before proceeding, ensure you have:"
echo "   1. Visited https://github.com/Shiva-destroyer/VisualCopy/wiki"
echo "   2. Clicked 'Create the first page' button"
echo "   3. Added any content and saved it"
echo ""
echo "   This creates the Wiki Git repository. Without this, the deployment will FAIL!"
echo ""
read -p "✅ Have you created the Wiki's first page? (y/n): " -n 1 -r
echo ""

if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    echo "❌ Deployment cancelled. Please create the Wiki first page and try again."
    echo ""
    echo "📖 Instructions:"
    echo "   1. Go to: https://github.com/Shiva-destroyer/VisualCopy/wiki"
    echo "   2. Click 'Create the first page'"
    echo "   3. Type 'Placeholder' in the editor"
    echo "   4. Click 'Save Page'"
    echo "   5. Re-run this script"
    exit 0
fi

# Create temporary working directory
echo ""
echo "📁 Creating temporary directory: $TEMP_DIR"
mkdir -p "$TEMP_DIR"

# Cleanup function (runs on exit or error)
cleanup() {
    echo ""
    echo "🧹 Cleaning up temporary files..."
    rm -rf "$TEMP_DIR"
    echo "✅ Cleanup complete"
}
trap cleanup EXIT

# Clone the Wiki repository
echo ""
echo "📥 Cloning Wiki repository..."
echo "   URL: $WIKI_REPO_URL"

if ! git clone "$WIKI_REPO_URL" "$TEMP_DIR"; then
    echo ""
    echo "❌ ERROR: Failed to clone Wiki repository!"
    echo ""
    echo "🔍 Possible causes:"
    echo "   1. Wiki hasn't been initialized (click 'Create the first page' on GitHub)"
    echo "   2. Authentication failed (check your GitHub credentials)"
    echo "   3. Repository URL is incorrect"
    echo ""
    echo "💡 Solution: Visit https://github.com/Shiva-destroyer/VisualCopy/wiki"
    echo "   and create the first page, then try again."
    exit 1
fi

echo "✅ Wiki repository cloned successfully"

# Remove existing markdown files (except .git folder)
echo ""
echo "🗑️  Removing old Wiki files..."
find "$TEMP_DIR" -maxdepth 1 -type f -name "*.md" -delete
echo "✅ Old files removed"

# Copy new documentation files
echo ""
echo "📋 Copying Wiki documentation from staging..."
cp "$WIKI_STAGING_DIR"/*.md "$TEMP_DIR/"

echo "✅ Files copied:"
ls -lh "$TEMP_DIR"/*.md

# Navigate to Wiki repo
cd "$TEMP_DIR"

# Stage changes
echo ""
echo "📦 Staging Wiki changes..."
git add .

# Check if there are changes to commit
if git diff --cached --quiet; then
    echo ""
    echo "ℹ️  No changes detected. Wiki is already up-to-date!"
    exit 0
fi

echo ""
echo "📋 Changes to be committed:"
git status --short

echo ""
read -p "💬 Enter commit message (or press Enter for default): " COMMIT_MSG

if [ -z "$COMMIT_MSG" ]; then
    COMMIT_MSG="docs: Update Wiki documentation (Architecture, Security, Quick Start)"
fi

# Commit changes
echo ""
echo "💾 Committing Wiki changes..."
git commit -m "$COMMIT_MSG"

echo ""
read -p "🚀 Ready to push to GitHub Wiki? (y/n): " -n 1 -r
echo ""

if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    echo "❌ Push cancelled by user"
    echo "💡 Changes are committed in: $TEMP_DIR"
    echo "   To push manually: cd $TEMP_DIR && git push origin master"
    trap - EXIT  # Disable cleanup so temp dir persists
    exit 0
fi

# Push to GitHub Wiki (Wiki uses 'master' branch by default, not 'main')
echo ""
echo "🚀 Pushing to GitHub Wiki..."
git push origin master

echo ""
echo "=========================================="
echo "  ✅ WIKI DEPLOYMENT SUCCESSFUL!"
echo "=========================================="
echo ""
echo "🎉 Wiki documentation deployed to:"
echo "   https://github.com/Shiva-destroyer/VisualCopy/wiki"
echo ""
echo "📖 Published Pages:"
echo "   • Home (Wiki landing page)"
echo "   • Quick Start Guide"
echo "   • Architecture and Logic"
echo "   • Security and Privacy"
echo "   • Project Structure"
echo ""
echo "💡 Tip: Visit the Wiki URL to verify all pages are visible"
echo ""
