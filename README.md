# MPVKit (AVFoundation Fork)

[![mpv](https://img.shields.io/badge/mpv-v0.41.0-blue.svg)](https://github.com/mpv-player/mpv)
[![ffmpeg](https://img.shields.io/badge/ffmpeg-n8.1-blue.svg)](https://github.com/FFmpeg/FFmpeg)
[![license](https://img.shields.io/badge/license-GPL--3.0-red.svg)](LICENSE)

This is a fork of [MPVKit](https://github.com/mpvkit/MPVKit) with **AVFoundation video output (`vo_avfoundation`)** support for iOS.

## Acknowledgments

Special thanks to the [MPVKit](https://github.com/mpvkit/MPVKit) team for creating and maintaining the original project that makes it possible to use `libmpv` on Apple platforms. This fork builds upon their excellent work.

Original project forked from [kingslay/FFmpegKit](https://github.com/kingslay/FFmpegKit).

## What's Different in This Fork?

This fork includes the **`vo_avfoundation`** video output driver, which:

- Renders video directly to `AVSampleBufferDisplayLayer`
- Enables **Picture-in-Picture (PiP)** support on iOS
- Uses hardware-accelerated VideoToolbox decoding
- Supports composite OSD for subtitle rendering in PiP

## ⭐ Support This Project

I'm doing this out of the goodness of my heart! If you find this project useful, please consider:

- ⭐ **Starring** this repository
- 👤 **Following** me on GitHub ([@Alexk2309](https://github.com/Alexk2309))

Your support helps me continue maintaining and improving this project. Thank you! 🙏

## License

**This fork is licensed under GPL v3.0.**

This build uses the GPL-licensed components including samba protocol support and other GPL libraries. By using this fork, you agree to the terms of the GPL v3.0 license.

See [LICENSE](LICENSE) for full details.

---

## Installation

### Swift Package Manager

Add to your `Package.swift`:

```swift
dependencies: [
    .package(url: "https://github.com/Alexk2309/MPVKit-ios.git", from: "0.41.0-av")
],
targets: [
    .target(
        name: "YourApp",
        dependencies: [
            .product(name: "MPVKit-GPL", package: "MPVKit-ios"),
        ]
    ),
]
```

Or use Xcode: File → Add Package Dependencies → Enter `https://github.com/Alexk2309/MPVKit-ios.git` → Select version `0.41.0-av` or later.

Supported platforms: **iOS 14+**, **tvOS 14+** (device + simulator).

### Usage

```swift
import MPVKit
```

## How to Build

All builds use the GPL configuration (this fork ships GPL-licensed components like libsmbclient).

```bash
# Default: build all supported platforms (ios, isimulator, tvos, tvsimulator)
make gpl platform=ios,tvos,tvsimulator,isimulator

# Or restrict to a subset
make gpl platform=ios,isimulator

# Clean all build artifacts and caches
make clean

# See full help
make help
```

The build produces a single combined framework at `dist/MPVKit-combined/MPVKit.xcframework.zip` (used by SPM consumers).

For a faster iteration loop on libmpv source changes only (skips rebuilding FFmpeg/openssl/etc.), use [scripts/rebuild-libmpv.sh](scripts/rebuild-libmpv.sh).

## Releasing a New Version

This fork ships as a single combined `MPVKit.xcframework.zip` consumed via Swift Package Manager. The release flow is:

```bash
# 1. Clean GPL build for all supported platforms
#    (produces dist/MPVKit-combined/MPVKit.xcframework.zip)
make gpl platform=ios,tvos,tvsimulator,isimulator

# 2. Get the SPM checksum for the produced zip
swift package compute-checksum dist/MPVKit-combined/MPVKit.xcframework.zip
```

Paste both the new tag URL and the checksum into the `MPVKit` `binaryTarget` in [Package.swift](Package.swift):

```swift
.binaryTarget(
    name: "MPVKit",
    url: "https://github.com/Alexk2309/MPVKit-ios/releases/download/<TAG>/MPVKit.xcframework.zip",
    checksum: "<CHECKSUM_FROM_STEP_2>"
),
```

Then commit, tag, push, create the GitHub release, and upload the zip:

```bash
# 3. Commit the Package.swift update and create the tag
git add Package.swift
git commit -m "Release <TAG>"
git tag <TAG>
git push origin main
git push origin <TAG>

# 4. Create the GitHub release (one-time per tag)
gh release create <TAG> \
    --repo Alexk2309/MPVKit-ios \
    --prerelease \
    --title <TAG> \
    --notes "Release notes here"

# 5. Upload the framework zip
./scripts/upload-framework.sh <TAG>
```

Once uploaded, downstream consumers can `swift package update` (or have Xcode resolve packages) to pull the new version.

## Use the Local Build in the Demo Apps

After `make gpl`, the combined `MPVKit.xcframework` is available at `dist/MPVKit-combined/xcframework/MPVKit.xcframework`. To make the demo apps (or your own project) consume the local build instead of downloading the released zip, swap the remote `binaryTarget` in [Package.swift](Package.swift) for a local path:

```swift
.binaryTarget(
    name: "MPVKit",
    path: "dist/MPVKit-combined/xcframework/MPVKit.xcframework"
),
```

Then reset Swift Package caches in Xcode (File → Packages → Reset Package Caches) so it picks up the local artifact.

## Related Projects

* [moltenvk-build](https://github.com/mpvkit/moltenvk-build)
* [libplacebo-build](https://github.com/mpvkit/libplacebo-build)
* [libdovi-build](https://github.com/mpvkit/libdovi-build)
* [libshaderc-build](https://github.com/mpvkit/libshaderc-build)
* [libluajit-build](https://github.com/mpvkit/libluajit-build)
* [libass-build](https://github.com/mpvkit/libass-build)
* [libbluray-build](https://github.com/mpvkit/libbluray-build)
* [libsmbclient-build](https://github.com/mpvkit/libsmbclient-build)
* [gnutls-build](https://github.com/mpvkit/gnutls-build)
* [openssl-build](https://github.com/mpvkit/openssl-build)
