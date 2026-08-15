Pod::Spec.new do |s|
  s.name             = 'MPVKit'
  s.version          = '0.41.0-av2'
  s.summary          = 'MPVKit with AVFoundation video and audio output for iOS/tvOS'
  s.description      = <<-DESC
    MPVKit fork with AVFoundation video output (vo_avfoundation) support.
    Features Picture-in-Picture, hardware-accelerated VideoToolbox decoding,
    composite OSD for subtitles, and HDR/Dolby Vision support.
    Also builds the avfoundation audio output (AVSampleBufferAudioRenderer)
    for iOS/tvOS, for HDMI routes the audiounit AO cannot open.
  DESC

  s.homepage         = 'https://github.com/streamyfin/MPVKit'
  s.license          = { :type => 'GPL-3.0', :text => 'GPL-3.0. See https://www.gnu.org/licenses/gpl-3.0.html' }
  s.author           = { 'streamyfin' => 'https://github.com/streamyfin' }
  s.source           = { :http => 'https://github.com/streamyfin/MPVKit/releases/download/0.41.0-av2/MPVKit.xcframework.zip' }

  s.ios.deployment_target  = '14.0'
  s.tvos.deployment_target = '14.0'

  s.static_framework = true
  s.requires_arc = true

  # Zip extracts to MPVKit.xcframework at the root
  s.vendored_frameworks = 'MPVKit.xcframework'

  # System frameworks
  s.frameworks = [
    'AVFoundation',
    'AudioToolbox',
    'CoreAudio',
    'CoreVideo',
    'CoreFoundation',
    'CoreMedia',
    'Metal',
    'QuartzCore',
    'VideoToolbox'
  ]

  # System libraries
  s.libraries = [
    'bz2',
    'iconv',
    'expat',
    'resolv',
    'xml2',
    'z',
    'c++'
  ]

  # Compiler flags - supports arm64 + x86_64 for simulators
  s.pod_target_xcconfig = {
    'VALID_ARCHS' => 'arm64 x86_64',
    'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'i386',
    'EXCLUDED_ARCHS[sdk=appletvsimulator*]' => 'i386'
  }

  s.user_target_xcconfig = {
    'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'i386',
    'EXCLUDED_ARCHS[sdk=appletvsimulator*]' => 'i386'
  }

  s.xcconfig = {
    'OTHER_LDFLAGS' => '$(inherited) -ObjC'
  }
end
