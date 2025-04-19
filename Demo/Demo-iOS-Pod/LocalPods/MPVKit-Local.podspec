Pod::Spec.new do |s|
  s.name             = 'MPVKit-Local'
  s.version          = '0.40.0'
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

  # Direct xcframework references to match SPM
  s.vendored_frameworks = [
    '../../../dist/release/xcframework/Libmpv.xcframework',
    '../../../Frameworks/Libavcodec.xcframework',
    '../../../Frameworks/Libavfilter.xcframework',
    '../../../Frameworks/Libavformat.xcframework',
    '../../../Frameworks/Libavutil.xcframework',
    '../../../Frameworks/Libswresample.xcframework',
    '../../../Frameworks/Libswscale.xcframework',
    '../../../Frameworks/Libavdevice.xcframework',
    '../../../Frameworks/Libcrypto.xcframework',
    '../../../Frameworks/Libssl.xcframework',
    '../../../Frameworks/gmp.xcframework',
    '../../../Frameworks/nettle.xcframework',
    '../../../Frameworks/hogweed.xcframework',
    '../../../Frameworks/gnutls.xcframework',
    '../../../Frameworks/Libass.xcframework',
    '../../../Frameworks/Libfreetype.xcframework',
    '../../../Frameworks/Libfribidi.xcframework',
    '../../../Frameworks/Libharfbuzz.xcframework',
    '../../../Frameworks/Libunibreak.xcframework',
  ]

  # Preserve paths to match SPM
  s.preserve_paths = '../../../Sources/**/*', '../../../dist/**/*', '../../../Frameworks/**/*'
end 