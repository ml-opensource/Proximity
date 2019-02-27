#
# Be sure to run `pod lib lint Proximity.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'Proximity'
  s.version          = '0.1.0'
  s.summary          = 'Detection of BLE devices in the immediate vicinity.'

  s.description      = <<-DESC
    Have you ever wanted Airpods-pairing-like notifications of when a BLE device is
    in the immediate vicinity of your device?
  
    Proximity uses RSSI values to determing when an advertising device is within the immediate
    vicinity of scanning device. This library can be used to both scan and advertise.
    
    Proximity uses names and service UUIDs to identify devices.
                       DESC

  s.homepage         = 'https://github.com/fuzz-productions/Proximity'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Eric Kunz' => 'ericjkunz@gmail.com' }
  s.source           = { :git => 'https://github.com/fuzz-productions/Proximity.git', :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/ericjkunz'

  s.ios.deployment_target = '10.0'

  s.source_files = 'Proximity/Classes/**/*'

  # s.public_header_files = 'Pod/Classes/**/*.h'
  s.frameworks = 'CoreBluetooth', 'os'
  
  s.swift_version = '4.2'
end
