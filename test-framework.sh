#!/bin/bash

# Function to check if framework exists
check_framework() {
    local framework_path="Frameworks/$1"
    if [ ! -d "$framework_path" ]; then
        echo "⚠️ Missing: $framework_path"
        return 1
    else
        echo "✅ Found: $framework_path"
        return 0
    fi
}

# FFmpeg Frameworks
echo "=== Checking FFmpeg Frameworks ==="
check_framework "Libavcodec.xcframework"
check_framework "Libavdevice.xcframework"
check_framework "Libavfilter.xcframework"
check_framework "Libavformat.xcframework"
check_framework "Libavutil.xcframework" 
check_framework "Libswresample.xcframework"
check_framework "Libswscale.xcframework"

# SSL/Crypto
echo "=== Checking SSL/Crypto Frameworks ==="
check_framework "Libssl.xcframework"
check_framework "Libcrypto.xcframework"

# Text rendering
echo "=== Checking Text Rendering Frameworks ==="
check_framework "Libass.xcframework"
check_framework "Libfreetype.xcframework"
check_framework "Libfribidi.xcframework"
check_framework "Libharfbuzz.xcframework"
check_framework "Libunibreak.xcframework"

# Graphics/Video Processing
echo "=== Checking Graphics & Video Processing Frameworks ==="
check_framework "MoltenVK.xcframework"
check_framework "Libshaderc_combined.xcframework"
check_framework "lcms2.xcframework"
check_framework "Libplacebo.xcframework"
check_framework "Libdovi.xcframework"

# GnuTLS related
echo "=== Checking GnuTLS Related Frameworks ==="
check_framework "gmp.xcframework"
check_framework "nettle.xcframework"
check_framework "hogweed.xcframework"
check_framework "gnutls.xcframework"

# Video codecs
echo "=== Checking Video Codec Frameworks ==="
check_framework "Libdav1d.xcframework"
check_framework "Libuavs3d.xcframework"

# GPL-specific
echo "=== Checking GPL-Specific Frameworks ==="
check_framework "Libsmbclient.xcframework"

# MPV Core
echo "=== Checking MPV Core Frameworks ==="
check_framework "Libmpv.xcframework"
check_framework "Libmpv-GPL.xcframework"
check_framework "Libuchardet.xcframework"
check_framework "Libbluray.xcframework"
check_framework "Libluajit.xcframework"

# GPL versions
echo "=== Checking GPL FFmpeg Frameworks ==="
check_framework "Libavcodec-GPL.xcframework"
check_framework "Libavdevice-GPL.xcframework"
check_framework "Libavfilter-GPL.xcframework"
check_framework "Libavformat-GPL.xcframework"
check_framework "Libavutil-GPL.xcframework"
check_framework "Libswresample-GPL.xcframework"
check_framework "Libswscale-GPL.xcframework"

echo "=== Check Complete ==="

# Count missing frameworks
missing=$(grep -c "⚠️ Missing" <<< "$(cat)")
if [ $missing -eq 0 ]; then
    echo "All frameworks found!"
else
    echo "$missing frameworks are missing"
fi 