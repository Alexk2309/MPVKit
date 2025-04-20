Pod::Spec.new do |s|
  s.name             = 'MPVKit'
  s.version          = '0.40.5'
  s.summary          = 'MPVKit'

  s.description      = <<-DESC
  MPV Player for iOS and macOS
  DESC

  s.homepage         = 'https://github.com/mpvkit/MPVKit'
  s.authors          = { 'alexkim' => 'alexkim5682@gmail.com' }
  s.license          = 'MIT'
  s.source           = { :git => 'https://github.com/alexk2309/MPVKit.git', :tag => s.version.to_s }

  s.ios.deployment_target = '13.0'
  s.tvos.deployment_target = '13.0'
  s.default_subspec = 'MPVKit'
  s.static_framework = true
  s.source_files = 'Sources/_MPVKit/**/*.{h,c,m}'

  # Shared dependencies subspec for common frameworks and libraries
  s.subspec 'SharedDeps' do |shared|
    # Common frameworks
    shared.frameworks = 'AudioToolbox', 'CoreVideo', 'CoreFoundation', 'CoreMedia', 'Metal', 'VideoToolbox'

    # Common libraries
    shared.libraries = 'bz2', 'iconv', 'expat', 'resolv', 'xml2', 'z', 'c++'

    # Common frameworks used by both FFmpeg and FFmpeg-GPL
    shared.vendored_frameworks = [
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

  # FFmpeg subspec that contains all dependencies
  s.subspec 'FFmpeg' do |ffmpeg|
    ffmpeg.dependency 'MPVKit/SharedDeps'
    
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
    ]
  end

  # FFmpeg-GPL subspec that contains all GPL dependencies
  s.subspec 'FFmpeg-GPL' do |ffmpeg_gpl|
    ffmpeg_gpl.dependency 'MPVKit/SharedDeps'

    # FFmpeg GPL components in exact same order as Package.swift
    ffmpeg_gpl.vendored_frameworks = [
      # Core FFmpeg components in Package.swift order
      'Frameworks/GPL/Libavcodec-GPL.xcframework',
      'Frameworks/GPL/Libavdevice-GPL.xcframework',
      'Frameworks/GPL/Libavfilter-GPL.xcframework',
      'Frameworks/GPL/Libavformat-GPL.xcframework',
      'Frameworks/GPL/Libavutil-GPL.xcframework',
      'Frameworks/GPL/Libswresample-GPL.xcframework',
      'Frameworks/GPL/Libswscale-GPL.xcframework',
      # Additional GPL-only frameworks
      'Frameworks/GPL/Libsmbclient.xcframework',
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
      'Frameworks/GPL/Libmpv-GPL.xcframework',
      'Frameworks/Libuchardet.xcframework',
      'Frameworks/Libbluray.xcframework',
    ]

    # macOS specific
    gpl.osx.vendored_frameworks = [
      'Frameworks/Libluajit.xcframework'
    ]
  end
end