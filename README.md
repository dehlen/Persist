# Persist
<img src="https://img.shields.io/badge/supports-Swift%20Package%20Manager-green.svg">
<img src="./docs/badge.svg">
<img src="https://img.shields.io/badge/Swift-5-orange">
<img src="https://img.shields.io/badge/Platforms-iOS | macOS-lightgrey">

This packages implements a wrapper around persistence related APIs on iOS/macOS for making your life easier, when all you want to do is to store that damn thing.

## Installation
Currently only Swift Package Manager is supported. 
Swift Package Manager is a dependency manager built into Xcode.

If you are using Xcode 11 or higher, go to File / Swift Packages / Add Package Dependency... and enter package repository URL https://github.com/dehlen/Persist.git, then follow the instructions.

To remove the dependency, select the project and open Swift Packages (which is next to Build Settings). You can add and remove packages from this tab.

## Usage

### User Defaults
To store key/value pairs in the UserDefaults this package implements three type-safe ways for you to choose from.

```swift
public extension UserDefaults.Key {
   static let someKey: UserDefaults.Key = "SomeKey"
}

let someValue = UserDefaults.standard[.someKey]
UserDefaults.standard[.someKey] = someValue
UserDefaults.register([
	.someKey: "Default"
])

// or:
let someProperty = UserDefaultsProperty<Int>("someProperty")
let someValue = someProperty.value
someProperty.value = 3
someProperty.remove()

// or: Property wrappers
@UserDefault("has_seen_app_introduction", defaultValue: false)
static var hasSeenAppIntroduction: Bool
```

### Storage
When you want to store Codable types on disk you can use the `Storage` implementation.
By default `Storage` allows you to store/retrieve arbitrary Codable files either in the documents or the caches directory.

```swift
// Store
Storage.store(myCodable, to: .documents, as: "storedFilename.json")

// Load
myCodable = Storage.retrieve("storedFilename.json", from: .documents, as: MyCodable.self)

// Clear
Storage.clear(.caches)
Storage.remove("storedFilename.json", from: .documents)
```  

### Core Data
`Persist` also provides you with a CoreData abstraction ready to use.
First initialize your CoreData client:

```swift
let client = CoreDataClient()
let client = CoreDataClient(container: CoreDataClient.inMemoryContainer)
let client = CoreDataClient(container: CoreDataClient.cloudKitContainer)

print("DB at: \(client.storeURLs)")
```
`Persist` comes with multiple store container implementations out of the box, but you can always pass in your own. If you want to use automatic sync with iCloud use the cloudKitContainer. Please note, that you need to configure your app first to be able to use that ([More Info](https://www.andrewcbancroft.com/blog/ios-development/data-persistence/getting-started-with-nspersistentcloudkitcontainer/#what-about-existing-apps)).

Next you can use the known CRUD operations on your database in a type-safe and boilerplate-free way. The package makes heavy use of Combine to provide you with a clean async API.

```swift
// Retrieve
client.object(for: fetchRequest)
client.objects(for: fetchRequest)

// Create
client.new(MyEntity.self)

// Delete
client.deleteObjects(ofType: MyEntity.self)
```

The framework also has support to store and retrieve Codable types to your database:

```swift
// Retrieve
let scratchpad = try client.decodeJSON(data, with: JSONDecoder(), to: MyCodable.self)
let scratchpad = try client.decodePlist(data, to: MyCodable.self)

// Save
let data = try client.encodeToJSON(scratchPad: .object(value: encodable, context: client.viewContext), with: JSONEncoder())
let data = try client.encodeToPlist(scratchPad: .object(value: codable, context: client.viewContext), with: PropertyListEncoder())
```

## Documentation
The documentation is generated thanks to [jazzy](https://github.com/realm/jazzy).

You can find the latest version here: [Documentation](./docs).

## License
The MIT License

Copyright (c) 2020 David Ehlen

See LICENSE file

