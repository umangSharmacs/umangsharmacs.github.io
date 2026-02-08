# Memories Photo Gallery

This folder contains photos that will be **automatically** displayed in the Memories section of the invitation page.

## How to Add Photos:

1. **Simply drop your image files** into this folder (JPG, JPEG, PNG, GIF, WEBP, SVG)
2. Run `bundle exec jekyll build` to rebuild the site
3. That's it! Photos will automatically appear in the gallery

## Automatic Features:

- ✨ **Auto-detection**: All image files are automatically found and displayed
- 📝 **Auto-captions**: Filenames are converted to captions (e.g., `summer-vacation.jpg` → "Summer vacation")
- 🔄 **No manual editing**: No need to edit any code or arrays
- 🖼️ **Supported formats**: JPG, JPEG, PNG, GIF, WEBP, SVG

## Tips:

- **Use descriptive filenames** - they become the captions!
  - Good: `beach-sunset-2024.jpg` → "Beach sunset 2024"
  - Avoid: `IMG_1234.jpg` → "Img 1234"
- **Optimize images** for web (recommended: max 2MB per image)
- **Use hyphens or underscores** in filenames instead of spaces
- Images are displayed in alphabetical order by filename

## Examples:

```
misc/invitation/memories/
├── 01-family-reunion.jpg      → "01 family reunion"
├── 02-birthday-party.png      → "02 birthday party"
├── 03-vacation-beach.jpg      → "03 vacation beach"
└── graduation-day.jpg         → "Graduation day"
```
