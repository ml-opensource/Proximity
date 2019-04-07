![proximity logo](images/logo_120.png)
# Proximity

[![Version](https://img.shields.io/cocoapods/v/Proximity.svg?style=flat)](https://cocoapods.org/pods/Proximity)
[![License](https://img.shields.io/cocoapods/l/Proximity.svg?style=flat)](https://cocoapods.org/pods/Proximity)
[![Platform](https://img.shields.io/cocoapods/p/Proximity.svg?style=flat)](https://cocoapods.org/pods/Proximity)

Proximity is a bluetooth library for detecting when a BLE device is held up to the host device.

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Installation

Proximity is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'Proximity'
```

## Use Cases

### Tap-to-book a conference room
iPads outside conference rooms could each advertise a different service (UUID). An iPhone monitoring for all of those services could know which conference room iPad it tapped based on the detected service of the peripheral. Then the iPhone could book a meeting at the particular room.

## Goals

- [ ] The ability to connect and communicate with devices once detected.

## Author

Eric Kunz, ericjkunz@gmail.com, Fuzz Productions

## License

Proximity is available under the MIT license. See the LICENSE file for more info.

"proximity" icon by Andrejis Kirma from thenounproject.com.