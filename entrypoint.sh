#!/bin/bash

set -eu

REPO_FULLNAME=$(jq -r ".repository.full_name" "$GITHUB_EVENT_PATH")

echo "## Initializing git repo..."
git init
echo "### Adding git remote..."
git remote add origin https://x-access-token:$GITHUB_TOKEN@github.com/$REPO_FULLNAME.git
echo "### Getting branch"
BRANCH=${GITHUB_REF#*refs/heads/}
echo "### git fetch $BRANCH ..."
git fetch origin $BRANCH
echo "### Branch: $BRANCH (ref: $GITHUB_REF )"
git checkout $BRANCH

echo "## Configuring git author..."
git config --global user.email "black-format@1337z.ninja"
git config --global user.name "Black Formatter for Python"

# Ignore workflow files (we may not touch them)
git update-index --assume-unchanged .github/workflows/*

echo "## Running black on Python source"
SRC=$(git ls-tree --full-tree -r HEAD | grep -e "\.\(py\|pyi\)\$" | cut -f 2)

black $SRC

echo "## Commiting files..."
git commit -a -m "Format Python code" || true

echo "## Pushing to $BRANCH"
git push -u origin $BRANCH
