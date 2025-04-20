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


  s.subspec 'MPVKit' do |mpv|
      mpv.libraries   = 'bz2', 'c++', 'iconv', 'resolv', 'xml2', 'z'
      mpv.osx.libraries = 'expat'
      mpv.frameworks  = 'AudioToolbox', 'AVFoundation', 'CoreMedia', 'VideoToolbox'

      # All frameworks in a single array
      mpv.vendored_frameworks = [
        # Core MPV framework
        'Frameworks/Libmpv.xcframework',

        # FFmpeg components
        'Frameworks/Libavcodec.xcframework',
        'Frameworks/Libavfilter.xcframework',
        'Frameworks/Libavformat.xcframework',
        'Frameworks/Libavutil.xcframework',
        'Frameworks/Libswresample.xcframework',
        'Frameworks/Libswscale.xcframework',
        'Frameworks/Libavdevice.xcframework',

        # SSL/Crypto
        'Frameworks/Libcrypto.xcframework',
        'Frameworks/Libssl.xcframework',

        # GnuTLS related
        'Frameworks/gmp.xcframework',
        'Frameworks/nettle.xcframework',
        'Frameworks/hogweed.xcframework',
        'Frameworks/gnutls.xcframework',

        # Text rendering and fonts
        'Frameworks/Libass.xcframework',
        'Frameworks/Libfreetype.xcframework',
        'Frameworks/Libfribidi.xcframework',
        'Frameworks/Libharfbuzz.xcframework',
        'Frameworks/Libunibreak.xcframework',
        'Frameworks/libfontconfig.xcframework',

        # Graphics and video processing
        'Frameworks/MoltenVK.xcframework',
        'Frameworks/Libshaderc_combined.xcframework',
        'Frameworks/lcms2.xcframework',
        'Frameworks/Libplacebo.xcframework',
        'Frameworks/Libdav1d.xcframework',
        'Frameworks/Libdovi.xcframework',

        # Character encoding detection
        'Frameworks/Libuchardet.xcframework',

        # Various media support
        'Frameworks/Libsmbclient.xcframework',
        'Frameworks/libzvbi.xcframework',
        'Frameworks/libsrt.xcframework',
        'Frameworks/Libuavs3d.xcframework',
        'Frameworks/Libbluray.xcframework',
      ]

      # macOS specific
      mpv.osx.vendored_frameworks = [
        'Frameworks/Libluajit.xcframework'
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
        'Frameworks/Libmpv-GPL.xcframework',

        # FFmpeg components (GPL versions)
        'Frameworks/Libavcodec-GPL.xcframework',
        'Frameworks/Libavfilter-GPL.xcframework',
        'Frameworks/Libavformat-GPL.xcframework',
        'Frameworks/Libavutil-GPL.xcframework',
        'Frameworks/Libswresample-GPL.xcframework',
        'Frameworks/Libswscale-GPL.xcframework',
        'Frameworks/Libavdevice-GPL.xcframework',

        # All the same dependencies as the regular version
        'Frameworks/Libcrypto.xcframework',
        'Frameworks/Libssl.xcframework',
        'Frameworks/gmp.xcframework',
        'Frameworks/nettle.xcframework',
        'Frameworks/hogweed.xcframework',
        'Frameworks/gnutls.xcframework',
        'Frameworks/Libass.xcframework',
        'Frameworks/Libfreetype.xcframework',
        'Frameworks/Libfribidi.xcframework',
        'Frameworks/Libharfbuzz.xcframework',
        'Frameworks/Libunibreak.xcframework',
        'Frameworks/libfontconfig.xcframework',
        'Frameworks/MoltenVK.xcframework',
        'Frameworks/Libshaderc_combined.xcframework',
        'Frameworks/lcms2.xcframework',
        'Frameworks/Libplacebo.xcframework',
        'Frameworks/Libdav1d.xcframework',
        'Frameworks/Libdovi.xcframework',
        'Frameworks/Libuchardet.xcframework',
        'Frameworks/Libsmbclient.xcframework',
        'Frameworks/libzvbi.xcframework',
        'Frameworks/libsrt.xcframework',
        'Frameworks/Libuavs3d.xcframework',
        'Frameworks/Libbluray.xcframework'
      ]

      # macOS specific
      gpl.osx.vendored_frameworks = [
        'Frameworks/Libluajit.xcframework'
      ]
  end

end