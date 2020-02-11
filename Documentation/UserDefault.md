# UserDefault

A type safe property wrapper to set and get values from UserDefaults with support for defaults values.

``` swift
@available(iOS 2.0, OSX 10.0, tvOS 9.0, watchOS 2.0, *) @propertyWrapper public struct UserDefault<Value: PropertyListValue>
```

Usage:

``` 
@UserDefault("has_seen_app_introduction", defaultValue: false)
static var hasSeenAppIntroduction: Bool
```

[Apple documentation on UserDefaults](https://developer.apple.com/documentation/foundation/userdefaults)

## Initializers

## init(\_:defaultValue:userDefaults:)

``` swift
public init(_ key: String, defaultValue: Value, userDefaults: UserDefaults = .standard)
```

## Properties

## wrappedValue

``` swift
var wrappedValue: Value
```
