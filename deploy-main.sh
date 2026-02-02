#!/bin/bash

# ================================================================
# DEPLOYMENT SCRIPT A: Push Main Repository to GitHub
# ================================================================
# 
# Purpose: Deploy the clean VisualCopy extension code to the main branch
# Repository: https://github.com/Shiva-destroyer/VisualCopy.git
# 
# Prerequisites:
#   1. Git must be installed and configured
#   2. You must have push access to the repository
#   3. SSH key or HTTPS credentials must be set up
# 
# ================================================================

set -e  # Exit on any error

echo "=========================================="
echo "  VisualCopy Main Repository Deployment"
echo "=========================================="
echo ""

# Navigate to project directory
PROJECT_DIR="/home/shivansh/VisionCopy"
cd "$PROJECT_DIR" || { echo "❌ Error: Project directory not found!"; exit 1; }

echo "📂 Current directory: $(pwd)"
echo ""

# Check if git repository is initialized
if [ ! -d ".git" ]; then
    echo "⚠️  Git repository not initialized. Initializing now..."
    git init
    git remote add origin https://github.com/Shiva-destroyer/VisualCopy.git
    echo "✅ Git repository initialized"
else
    echo "✅ Git repository detected"
fi

echo ""
echo "📋 Checking repository status..."
git status

echo ""
read -p "📌 Do you want to proceed with staging all files? (y/n): " -n 1 -r
echo ""

if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    echo "❌ Deployment cancelled by user"
    exit 0
fi

# Stage all changes
echo ""
echo "📦 Staging all changes..."
git add .

echo ""
echo "📋 Staged files:"
git status --short

echo ""
read -p "💬 Enter commit message (or press Enter for default): " COMMIT_MSG

if [ -z "$COMMIT_MSG" ]; then
    COMMIT_MSG="docs: Reorganize repository structure and migrate documentation to Wiki"
fi

# Commit changes
echo ""
echo "💾 Committing changes..."
git commit -m "$COMMIT_MSG"

echo ""
echo "🔍 Checking remote configuration..."
git remote -v

echo ""
read -p "🚀 Ready to push to GitHub main branch? (y/n): " -n 1 -r
echo ""

if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    echo "❌ Push cancelled by user"
    echo "💡 Your changes are committed locally. Run 'git push origin main' manually when ready."
    exit 0
fi

# Push to GitHub
echo ""
echo "🚀 Pushing to GitHub..."
git push origin main

echo ""
echo "=========================================="
echo "  ✅ DEPLOYMENT SUCCESSFUL!"
echo "=========================================="
echo ""
echo "🎉 Main repository deployed to:"
echo "   https://github.com/Shiva-destroyer/VisualCopy"
echo ""
echo "📋 Next Steps:"
echo "   1. Visit the repository to verify changes"
echo "   2. Run Script B (deploy-wiki.sh) to publish Wiki documentation"
echo ""
