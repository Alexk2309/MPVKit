// swift-tools-version:5.9

import PackageDescription

let package = Package(
    name: "MPVKit",
    platforms: [.macOS(.v11), .iOS(.v14), .tvOS(.v14), .visionOS(.v1)],
    products: [
        .library(
            name: "MPVKit-GPL",
            targets: ["_MPVKit-GPL"]
        ),
    ],
    targets: [
        .target(
            name: "_MPVKit-GPL",
            dependencies: ["MPVKit"],
            path: "Sources/_MPVKit-GPL",
            linkerSettings: [
                .linkedFramework("AVFoundation"),
                .linkedFramework("AudioToolbox"),
                .linkedFramework("CoreAudio"),
                .linkedFramework("CoreVideo"),
                .linkedFramework("CoreFoundation"),
                .linkedFramework("CoreMedia"),
                .linkedFramework("Metal"),
                .linkedFramework("QuartzCore"),
                .linkedFramework("VideoToolbox"),
                .linkedLibrary("bz2"),
                .linkedLibrary("iconv"),
                .linkedLibrary("xml2"),
                .linkedLibrary("z"),
                .linkedLibrary("c++"),
                .linkedLibrary("resolv"),
                .linkedLibrary("expat"),
            ]
        ),
        // Combined framework - includes libmpv, FFmpeg, and all dependencies
        .binaryTarget(
            name: "MPVKit",
            url: "https://github.com/mpv-ios/MPVKit/releases/download/0.41.0-av/MPVKit.xcframework.zip",
            checksum: "875b4bae936d1e63b272688b3dc65f62f9b82fb21f871fac3a5bf814fdd067d9"
        ),
    ]
)
