# Storage

``` swift
public class Storage
```

## Nested Types

  - [Storage.StorageError](Storage_StorageError)
  - [Storage.Directory](Storage_Directory)

## Methods

## store(\_:to:as:)

Store an encodable struct to the specified directory on disk
\*  @param object      The encodable struct to store
\*  @param directory   Where to store the struct
\*  @param fileName    What to name the file where the struct data will be stored
\*

``` swift
public static func store<T: Encodable>(_ object: T, to directory: Directory, as fileName: String) throws
```

## retrieve(\_:from:as:)

Retrieve and convert an Object from a file on disk
\*  @param fileName    Name of the file where struct data is stored
\*  @param directory   Directory where Object data is stored
\*  @param type        Object type (i.e. Message.self)
\*  @return decoded    Object model(s) of data
\*

``` swift
public static func retrieve<T: Decodable>(_ fileName: String, from directory: Directory, as type: T.Type) throws -> T
```

## clear(\_:)

Remove all files at specified directory

``` swift
public static func clear(_ directory: Directory) throws
```

## remove(\_:from:)

Remove specified file from specified directory

``` swift
public static func remove(_ fileName: String, from directory: Directory) throws
```
