# UserDefaultsProperty

Use like:

``` swift
public final class UserDefaultsProperty<T>
```

``` 
let someProperty = UserDefaultsProperty<Int>("someProperty")
let someValue = someProperty.value
someProperty.value = 3
```

## Initializers

## init(\_:)

``` swift
public init(_ identifier: String)
```

## Properties

## value

``` swift
var value: T?
```

## Methods

## remove()

``` swift
public func remove()
```
