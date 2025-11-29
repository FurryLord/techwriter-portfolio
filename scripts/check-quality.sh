#!/bin/bash

# Quality check script for technical documentation
echo "🔍 Running quality checks..."

# Check for common issues in markdown files
echo "📝 Checking markdown files..."

# Check for broken internal links
echo "🔗 Checking internal links..."
if command -v markdown-link-check &> /dev/null; then
    find content -name "*.md" -exec markdown-link-check {} \;
else
    echo "⚠️  markdown-link-check not installed, skipping link check"
fi

# Check for consistent terminology
echo "📚 Checking terminology consistency..."
if command -v textlint &> /dev/null; then
    find content -name "*.md" -exec textlint {} \;
else
    echo "⚠️  textlint not installed, skipping text quality check"
fi

# Check for proper Hugo front matter
echo "🏗️  Checking Hugo front matter..."
for file in content/**/*.md; do
    if ! head -n 20 "$file" | grep -q "^---$"; then
        echo "❌ Missing front matter in $file"
    fi
done

# Check for images without alt text (basic check)
echo "🖼️  Checking images..."
grep -r "\!\[\]" content/ && echo "⚠️  Found images without alt text"

# Check for TODO comments
echo "📋 Checking for TODO comments..."
grep -r -i "todo\|fixme\|hack" content/ && echo "⚠️  Found TODO/FIXME comments"

# Check file sizes
echo "📏 Checking file sizes..."
find content -name "*.md" -exec wc -l {} \; | awk '$1 > 200 {print "⚠️  Long file:", $2, "-",$1, "lines"}'

echo "✅ Quality checks completed!"
