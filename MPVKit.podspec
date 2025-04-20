Pod::Spec.new do |s|
  s.name             = 'MPVKit'
  s.version          = '0.40.0'
  s.summary          = 'MPVKit'

  s.description      = <<-DESC
  MPV Player for iOS and macOS
  DESC

  s.homepage         = 'https://github.com/mpvkit/MPVKit'
  s.authors          = { 'alexkim' => 'yourmail@example.com' }
  s.license          = 'MIT'
  s.source           = { :git => 'https://github.com/mpvkit/MPVKit.git', :tag => s.version.to_s }

  s.ios.deployment_target = '13.0'
  s.osx.deployment_target = '10.15'
  s.tvos.deployment_target = '13.0'
  s.default_subspec = 'MPVKit'
  s.static_framework = true
  s.source_files = 'Sources/_MPVKit/**/*.{h,c,m}'

  # FFmpeg subspec that contains all dependencies
  s.subspec 'FFmpeg' do |ffmpeg|
    # These match the frameworks from Package.swift
    ffmpeg.frameworks = 'AudioToolbox', 'CoreVideo', 'CoreFoundation', 'CoreMedia', 'Metal', 'VideoToolbox'

    # These match the libraries from Package.swift
    ffmpeg.libraries = 'bz2', 'iconv', 'expat', 'resolv', 'xml2', 'z', 'c++'


    # FFmpeg components in exact same order as Package.swift
    ffmpeg.vendored_frameworks = [
      # Core FFmpeg components in Package.swift order
      'Frameworks/Libavcodec.xcframework',
      'Frameworks/Libavdevice.xcframework',
      'Frameworks/Libavfilter.xcframework',
      'Frameworks/Libavformat.xcframework',
      'Frameworks/Libavutil.xcframework',
      'Frameworks/Libswresample.xcframework',
      'Frameworks/Libswscale.xcframework',

      # SSL/Crypto
      'Frameworks/Libssl.xcframework',
      'Frameworks/Libcrypto.xcframework',

      # Text rendering and fonts
      'Frameworks/Libass.xcframework',
      'Frameworks/Libfreetype.xcframework',
      'Frameworks/Libfribidi.xcframework',
      'Frameworks/Libharfbuzz.xcframework',

      # Graphics and video processing
      'Frameworks/MoltenVK.xcframework',
      'Frameworks/Libshaderc_combined.xcframework',
      'Frameworks/lcms2.xcframework',
      'Frameworks/Libplacebo.xcframework',
      'Frameworks/Libdovi.xcframework',
      'Frameworks/Libunibreak.xcframework',

      # GnuTLS related
      'Frameworks/gmp.xcframework',
      'Frameworks/nettle.xcframework',
      'Frameworks/hogweed.xcframework',
      'Frameworks/gnutls.xcframework',

      # Video codecs
      'Frameworks/Libdav1d.xcframework',
      'Frameworks/Libuavs3d.xcframework',
    ]
  end

  # FFmpeg-GPL subspec that contains all GPL dependencies
  s.subspec 'FFmpeg-GPL' do |ffmpeg_gpl|
    # These match the frameworks from Package.swift
    ffmpeg_gpl.frameworks = 'AudioToolbox', 'CoreVideo', 'CoreFoundation', 'CoreMedia', 'Metal', 'VideoToolbox'

    # These match the libraries from Package.swift
    ffmpeg_gpl.libraries = 'bz2', 'iconv', 'expat', 'resolv', 'xml2', 'z', 'c++'


    # FFmpeg GPL components in exact same order as Package.swift
    ffmpeg_gpl.vendored_frameworks = [
      # Core FFmpeg components in Package.swift order
      'Frameworks/Libavcodec-GPL.xcframework',
      'Frameworks/Libavdevice-GPL.xcframework',
      'Frameworks/Libavfilter-GPL.xcframework',
      'Frameworks/Libavformat-GPL.xcframework',
      'Frameworks/Libavutil-GPL.xcframework',
      'Frameworks/Libswresample-GPL.xcframework',
      'Frameworks/Libswscale-GPL.xcframework',

      # SSL/Crypto
      'Frameworks/Libssl.xcframework',
      'Frameworks/Libcrypto.xcframework',

      # Text rendering and fonts
      'Frameworks/Libass.xcframework',
      'Frameworks/Libfreetype.xcframework',
      'Frameworks/Libfribidi.xcframework',
      'Frameworks/Libharfbuzz.xcframework',

      # Graphics and video processing
      'Frameworks/MoltenVK.xcframework',
      'Frameworks/Libshaderc_combined.xcframework',
      'Frameworks/lcms2.xcframework',
      'Frameworks/Libplacebo.xcframework',
      'Frameworks/Libdovi.xcframework',
      'Frameworks/Libunibreak.xcframework',

      # GnuTLS related
      'Frameworks/gmp.xcframework',
      'Frameworks/nettle.xcframework',
      'Frameworks/hogweed.xcframework',
      'Frameworks/gnutls.xcframework',

      # Video codecs
      'Frameworks/Libdav1d.xcframework',
      'Frameworks/Libuavs3d.xcframework',

      # Additional GPL-only frameworks
      'Frameworks/Libsmbclient.xcframework',
    ]
  end

  # Main MPVKit subspec
  s.subspec 'MPVKit' do |mpv|
    mpv.dependency 'MPVKit/FFmpeg'
    mpv.frameworks = 'AVFoundation', 'CoreAudio'

    # Core MPV framework
    mpv.vendored_frameworks = [
      'Frameworks/Libmpv.xcframework',
      'Frameworks/Libuchardet.xcframework',
      'Frameworks/Libbluray.xcframework',
    ]

    # macOS specific
    mpv.osx.vendored_frameworks = [
      'Frameworks/Libluajit.xcframework'
    ]
  end

  # GPL version subspec
  s.subspec 'MPVKit-GPL' do |gpl|
    gpl.dependency 'MPVKit/FFmpeg-GPL'
    gpl.frameworks = 'AVFoundation', 'CoreAudio'

    # Core MPV framework (GPL version)
    gpl.vendored_frameworks = [
      'Frameworks/Libmpv-GPL.xcframework',
      'Frameworks/Libuchardet.xcframework',
      'Frameworks/Libbluray.xcframework',
    ]

    # macOS specific
    gpl.osx.vendored_frameworks = [
      'Frameworks/Libluajit.xcframework'
    ]
  end
end