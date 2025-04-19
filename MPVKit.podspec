Pod::Spec.new do |s|
  s.name             = 'MPVKit'
  s.version          = '0.40.0'
  s.summary          = 'MPVKit'

  s.description      = <<-DESC
  MPV Player for iOS and macOS
  DESC

  s.homepage         = 'https://github.com/Alexk2309/MPVKit.git'
  s.authors          = { 'alexkim' => 'alexkim5682@gmail.com' }
  s.license          = 'MIT'
  s.source           = { :git => 'https://github.com/Alexk2309/MPVKit.git', :tag => s.version.to_s }

  s.ios.deployment_target = '13.0'
  s.osx.deployment_target = '10.15'
  s.tvos.deployment_target = '13.0'
  s.default_subspec = 'MPVKit'
  s.static_framework = true
  s.source_files = 'Sources/_MPVKit/**/*.{h,c,m}'

  s.subspec 'MPVKit' do |mpv|
      mpv.libraries   = 'bz2', 'c++', 'iconv', 'resolv', 'xml2', 'z'
      mpv.osx.libraries = 'expat'
      mpv.frameworks  = 'AudioToolbox', 'AVFoundation', 'CoreMedia', 'VideoToolbox'

      # All frameworks in a single array
      mpv.vendored_frameworks = [
        # Core MPV framework
        'Sources/Libmpv.xcframework',

        # FFmpeg components
        'Sources/Libavcodec.xcframework',
        'Sources/Libavfilter.xcframework',
        'Sources/Libavformat.xcframework',
        'Sources/Libavutil.xcframework',
        'Sources/Libswresample.xcframework',
        'Sources/Libswscale.xcframework',
        'Sources/Libavdevice.xcframework',

        # SSL/Crypto
        'Sources/Libcrypto.xcframework',
        'Sources/Libssl.xcframework',

        # GnuTLS related
        'Sources/gmp.xcframework',
        'Sources/nettle.xcframework',
        'Sources/hogweed.xcframework',
        'Sources/gnutls.xcframework',

        # Text rendering and fonts
        'Sources/Libass.xcframework',
        'Sources/Libfreetype.xcframework',
        'Sources/Libfribidi.xcframework',
        'Sources/Libharfbuzz.xcframework',
        'Sources/Libunibreak.xcframework',
        'Sources/libfontconfig.xcframework',

        # Graphics and video processing
        'Sources/MoltenVK.xcframework',
        'Sources/Libshaderc_combined.xcframework',
        'Sources/lcms2.xcframework',
        'Sources/Libplacebo.xcframework',
        'Sources/Libdav1d.xcframework',
        'Sources/Libdovi.xcframework',

        # Character encoding detection
        'Sources/Libuchardet.xcframework',

        # Various media support
        'Sources/Libsmbclient.xcframework',
        'Sources/libzvbi.xcframework',
        'Sources/libsrt.xcframework',
        'Sources/Libuavs3d.xcframework'
      ]

      # macOS specific
      mpv.osx.vendored_frameworks = [
        'Sources/Libbluray.xcframework',
        'Sources/Libluajit.xcframework'
      ]
  end

  # GPL version subspec (optional)
  s.subspec 'MPVKit-GPL' do |gpl|
      gpl.libraries   = 'bz2', 'c++', 'iconv', 'resolv', 'xml2', 'z'
      gpl.osx.libraries = 'expat'
      gpl.frameworks  = 'AudioToolbox', 'AVFoundation', 'CoreMedia', 'VideoToolbox'

      # All frameworks in a single array
      gpl.vendored_frameworks = [
        # Core MPV framework (GPL version)
        'Sources/Libmpv-GPL.xcframework',

        # FFmpeg components (GPL versions)
        'Sources/Libavcodec-GPL.xcframework',
        'Sources/Libavfilter-GPL.xcframework',
        'Sources/Libavformat-GPL.xcframework',
        'Sources/Libavutil-GPL.xcframework',
        'Sources/Libswresample-GPL.xcframework',
        'Sources/Libswscale-GPL.xcframework',
        'Sources/Libavdevice-GPL.xcframework',

        # All the same dependencies as the regular version
        'Sources/Libcrypto.xcframework',
        'Sources/Libssl.xcframework',
        'Sources/gmp.xcframework',
        'Sources/nettle.xcframework',
        'Sources/hogweed.xcframework',
        'Sources/gnutls.xcframework',
        'Sources/Libass.xcframework',
        'Sources/Libfreetype.xcframework',
        'Sources/Libfribidi.xcframework',
        'Sources/Libharfbuzz.xcframework',
        'Sources/Libunibreak.xcframework',
        'Sources/libfontconfig.xcframework',
        'Sources/MoltenVK.xcframework',
        'Sources/Libshaderc_combined.xcframework',
        'Sources/lcms2.xcframework',
        'Sources/Libplacebo.xcframework',
        'Sources/Libdav1d.xcframework',
        'Sources/Libdovi.xcframework',
        'Sources/Libuchardet.xcframework',
        'Sources/Libsmbclient.xcframework',
        'Sources/libzvbi.xcframework',
        'Sources/libsrt.xcframework',
        'Sources/Libuavs3d.xcframework'
      ]

      # macOS specific
      gpl.osx.vendored_frameworks = [
        'Sources/Libbluray.xcframework',
        'Sources/Libluajit.xcframework'
      ]
  end

  # Preserve paths for all frameworks
  s.preserve_paths = 'Frameworks/**/*'
end
