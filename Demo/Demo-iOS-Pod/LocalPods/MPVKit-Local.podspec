Pod::Spec.new do |s|
  s.name             = 'MPVKit-Local'
  s.version          = '0.40.4'
  s.summary          = 'MPVKit local build for direct linking'
  s.description      = <<-DESC
  Local MPV Player library for iOS and macOS that mimics the SPM structure
  DESC

  s.homepage         = 'https://github.com/Alexk2309/MPVKit.git'
  s.authors          = { 'alexkim' => 'alexkim5682@gmail.com' }
  s.license          = 'MIT'
  s.source           = { :git => 'https://github.com/Alexk2309/MPVKit.git', :tag => s.version.to_s }

  s.ios.deployment_target = '13.0'
  s.static_framework = true
  
  # Use dummy file as source to match SPM approach
  s.source_files = '../../../Sources/_MPVKit/**/*.{h,c,m}'
  
  # Libraries that need to be linked
  s.libraries = 'bz2', 'c++', 'iconv', 'resolv', 'xml2', 'z'
  s.frameworks = 'AudioToolbox', 'AVFoundation', 'CoreMedia', 'VideoToolbox'

  # Shared dependencies
  s.vendored_frameworks = [
    # SSL/Crypto
    '../../../Frameworks/Libcrypto.xcframework',
    '../../../Frameworks/Libssl.xcframework',
    
    # GnuTLS related
    '../../../Frameworks/gmp.xcframework',
    '../../../Frameworks/nettle.xcframework',
    '../../../Frameworks/hogweed.xcframework',
    '../../../Frameworks/gnutls.xcframework',
    
    # Text rendering and fonts
    '../../../Frameworks/Libass.xcframework',
    '../../../Frameworks/Libfreetype.xcframework',
    '../../../Frameworks/Libfribidi.xcframework',
    '../../../Frameworks/Libharfbuzz.xcframework',
    '../../../Frameworks/Libunibreak.xcframework',
    
    # Video codecs
    '../../../Frameworks/Libdav1d.xcframework',
    
    # FFmpeg components
    '../../../Frameworks/Libavcodec.xcframework',
    '../../../Frameworks/Libavfilter.xcframework',
    '../../../Frameworks/Libavformat.xcframework',
    '../../../Frameworks/Libavutil.xcframework',
    '../../../Frameworks/Libswresample.xcframework',
    '../../../Frameworks/Libswscale.xcframework',
    '../../../Frameworks/Libavdevice.xcframework',
    
    # MPV core
    '../../../dist/release/xcframework/Libmpv.xcframework',
  ]

  # Preserve paths to match SPM
  s.preserve_paths = '../../../Sources/**/*', '../../../dist/**/*', '../../../Frameworks/**/*'
end 