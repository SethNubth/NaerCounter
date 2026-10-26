#!/bin/bash
VERSION=$(grep "## Version" NaerCounter.toc | sed 's/## Version: //')
ADDON_NAME="NaerCounter"
ZIPNAME="${ADDON_NAME}-${VERSION}-Naerzone-WotLK.zip"

echo "Packaging ${ADDON_NAME} v${VERSION} for Naerzone WotLK 3.3.5a..."

rm -f "$ZIPNAME"
rm -rf build

mkdir -p build/$ADDON_NAME/textures
mkdir -p build/$ADDON_NAME/textures/farming

echo "Copying Lua files..."
cp NaerCounter.toc Core.lua GuideData.lua RoutesData.lua FarmingData.lua Tracking.lua \
   Counter.lua Routes.lua UI.lua README.md \
   build/$ADDON_NAME/ 2>/dev/null || \
cp NaerCounter.toc Core.lua RoutesData.lua FarmingData.lua Tracking.lua \
   Counter.lua Routes.lua UI.lua \
   build/$ADDON_NAME/

echo "Copying textures..."
cp textures/*.tga build/$ADDON_NAME/textures/ 2>/dev/null || echo "No textures/*.tga found - skipping"
cp textures/*.blp build/$ADDON_NAME/textures/ 2>/dev/null || echo "No textures/*.blp found - skipping"
cp textures/farming/*.tga build/$ADDON_NAME/textures/farming/ 2>/dev/null || echo "No farming textures"
cp textures/farming/*.blp build/$ADDON_NAME/textures/farming/ 2>/dev/null || true

# Verificar que existe el TOC
if [ ! -f "build/$ADDON_NAME/NaerCounter.toc" ]; then
    echo "ERROR: NaerCounter.toc not found in build!"
    exit 1
fi

cd build
zip -r "../$ZIPNAME" $ADDON_NAME
cd ..
rm -rf build

echo ""
echo "✅ Created $ZIPNAME"
echo "   Size: $(du -h $ZIPNAME | cut -f1)"
echo ""
echo "Ready for Naerzone WotLK 3.3.5a:"
echo "  - Drop Interface/AddOns/NaerCounter"
echo "  - /reload in game"
echo "  - /naercounter or /nc"
