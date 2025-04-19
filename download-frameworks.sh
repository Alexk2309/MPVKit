#!/bin/bash

# Create Frameworks directory
mkdir -p Frameworks

# Function to download and extract a framework
download_framework() {
    local name=$1
    local url=$2
    local output_dir="Frameworks/$name.xcframework"
    
    echo "Processing $name..."
    
    # Check if directory already exists
    if [ -d "$output_dir" ]; then
        echo "Framework $name already exists. Removing it..."
        rm -rf "$output_dir"
    fi
    
    # Create a temporary directory
    local temp_dir=$(mktemp -d)
    local zip_file="$temp_dir/$name.xcframework.zip"
    
    # Download the framework
    echo "Downloading $url..."
    curl -L -o "$zip_file" "$url"
    
    # Extract the framework
    echo "Extracting $name.xcframework..."
    unzip -q "$zip_file" -d "$temp_dir"
    
    # Move the framework to the Frameworks directory
    mv "$temp_dir"/*.xcframework "$output_dir"
    
    # Clean up
    rm -rf "$temp_dir"
    
    echo "Completed $name"
}

# MPV and FFmpeg main frameworks
download_framework "Libmpv" "https://github.com/mpvkit/MPVKit/releases/download/0.40.0/Libmpv.xcframework.zip"
download_framework "Libavcodec" "https://github.com/mpvkit/MPVKit/releases/download/0.40.0/Libavcodec.xcframework.zip"
download_framework "Libavdevice" "https://github.com/mpvkit/MPVKit/releases/download/0.40.0/Libavdevice.xcframework.zip"
download_framework "Libavformat" "https://github.com/mpvkit/MPVKit/releases/download/0.40.0/Libavformat.xcframework.zip"
download_framework "Libavfilter" "https://github.com/mpvkit/MPVKit/releases/download/0.40.0/Libavfilter.xcframework.zip"
download_framework "Libavutil" "https://github.com/mpvkit/MPVKit/releases/download/0.40.0/Libavutil.xcframework.zip"
download_framework "Libswresample" "https://github.com/mpvkit/MPVKit/releases/download/0.40.0/Libswresample.xcframework.zip"
download_framework "Libswscale" "https://github.com/mpvkit/MPVKit/releases/download/0.40.0/Libswscale.xcframework.zip"

# GPL versions
download_framework "Libmpv-GPL" "https://github.com/mpvkit/MPVKit/releases/download/0.40.0/Libmpv-GPL.xcframework.zip"
download_framework "Libavcodec-GPL" "https://github.com/mpvkit/MPVKit/releases/download/0.40.0/Libavcodec-GPL.xcframework.zip"
download_framework "Libavdevice-GPL" "https://github.com/mpvkit/MPVKit/releases/download/0.40.0/Libavdevice-GPL.xcframework.zip"
download_framework "Libavformat-GPL" "https://github.com/mpvkit/MPVKit/releases/download/0.40.0/Libavformat-GPL.xcframework.zip"
download_framework "Libavfilter-GPL" "https://github.com/mpvkit/MPVKit/releases/download/0.40.0/Libavfilter-GPL.xcframework.zip"
download_framework "Libavutil-GPL" "https://github.com/mpvkit/MPVKit/releases/download/0.40.0/Libavutil-GPL.xcframework.zip"
download_framework "Libswresample-GPL" "https://github.com/mpvkit/MPVKit/releases/download/0.40.0/Libswresample-GPL.xcframework.zip"
download_framework "Libswscale-GPL" "https://github.com/mpvkit/MPVKit/releases/download/0.40.0/Libswscale-GPL.xcframework.zip"

# OpenSSL
download_framework "Libcrypto" "https://github.com/mpvkit/openssl-build/releases/download/3.2.0/Libcrypto.xcframework.zip"
download_framework "Libssl" "https://github.com/mpvkit/openssl-build/releases/download/3.2.0/Libssl.xcframework.zip"

# GnuTLS related
download_framework "gmp" "https://github.com/mpvkit/gnutls-build/releases/download/3.8.3/gmp.xcframework.zip"
download_framework "nettle" "https://github.com/mpvkit/gnutls-build/releases/download/3.8.3/nettle.xcframework.zip"
download_framework "hogweed" "https://github.com/mpvkit/gnutls-build/releases/download/3.8.3/hogweed.xcframework.zip"
download_framework "gnutls" "https://github.com/mpvkit/gnutls-build/releases/download/3.8.3/gnutls.xcframework.zip"

# libass and related
download_framework "Libunibreak" "https://github.com/mpvkit/libass-build/releases/download/0.17.3/Libunibreak.xcframework.zip"
download_framework "Libfreetype" "https://github.com/mpvkit/libass-build/releases/download/0.17.3/Libfreetype.xcframework.zip"
download_framework "Libfribidi" "https://github.com/mpvkit/libass-build/releases/download/0.17.3/Libfribidi.xcframework.zip"
download_framework "Libharfbuzz" "https://github.com/mpvkit/libass-build/releases/download/0.17.3/Libharfbuzz.xcframework.zip"
download_framework "Libass" "https://github.com/mpvkit/libass-build/releases/download/0.17.3/Libass.xcframework.zip"

# Others
download_framework "Libsmbclient" "https://github.com/mpvkit/libsmbclient-build/releases/download/4.15.13/Libsmbclient.xcframework.zip"
download_framework "Libbluray" "https://github.com/mpvkit/libbluray-build/releases/download/1.3.4/Libbluray.xcframework.zip"
download_framework "Libuavs3d" "https://github.com/mpvkit/libuavs3d-build/releases/download/1.2.1/Libuavs3d.xcframework.zip"
download_framework "Libdovi" "https://github.com/mpvkit/libdovi-build/releases/download/3.3.0/Libdovi.xcframework.zip"
download_framework "MoltenVK" "https://github.com/mpvkit/moltenvk-build/releases/download/1.2.9-fix/MoltenVK.xcframework.zip"
download_framework "Libshaderc_combined" "https://github.com/mpvkit/libshaderc-build/releases/download/2024.2.0/Libshaderc_combined.xcframework.zip"
download_framework "lcms2" "https://github.com/mpvkit/libplacebo-build/releases/download/7.349.0/lcms2.xcframework.zip"
download_framework "Libplacebo" "https://github.com/mpvkit/libplacebo-build/releases/download/7.349.0/Libplacebo.xcframework.zip"
download_framework "Libdav1d" "https://github.com/mpvkit/libdav1d-build/releases/download/1.4.3/Libdav1d.xcframework.zip"
download_framework "Libuchardet" "https://github.com/mpvkit/libuchardet-build/releases/download/0.0.8/Libuchardet.xcframework.zip"
download_framework "Libluajit" "https://github.com/mpvkit/libluajit-build/releases/download/2.1.0/Libluajit.xcframework.zip"

echo "All frameworks have been downloaded and extracted to the Frameworks directory." 