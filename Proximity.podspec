Pod::Spec.new do |s|
  s.name             = 'Proximity'
  s.version          = '0.1.0'
  s.summary          = 'Detect BLE devices in the immediate vicinity.'

  s.description      = <<-DESC
Have you ever wanted Airpods-like nearby device notifications?

Using RSSI values, Proximity detects BLE devices in the immediate vicinity. Very likely being held directly up to the BLE peripheral.
                       DESC

  s.homepage         = 'https://github.com/fuzz-productions/Proximity'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Eric Kunz' => 'ericjkunz@gmail.com' }
  s.source           = { :git => 'https://github.com/fuzz-productions/Proximity.git', :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/ericjkunz'

  s.ios.deployment_target = '10.0'
  s.swift_version = '4.0'

  s.source_files = 'Proximity/Classes/**/*'

  # s.public_header_files = 'Pod/Classes/**/*.h'
  s.frameworks = 'CoreBluetooth'
end
