# PersistenceStore

Protocol for persistence stores used by `SynchronizationManager`

``` swift
public protocol PersistenceStore
```

## Conforming Types

[`CoreStack`](CoreStack)

## Required Methods

## create(type:)

Create a new object of the given type.

``` swift
func create<T>(type: Any.Type) throws -> T
```

  - parameter type: The type of which a new object should be created

### Throws

If a invalid type was specified

### Returns

A newly created object of the given type

## delete(type:predicate:)

Delete objects of the given type which also match the predicate.

``` swift
func delete(type: Any.Type, predicate: NSPredicate) throws
```

  - parameter type:      The type of which objects should be deleted

<!-- end list -->

  - parameter predicate: The predicate used for matching objects to delete

### Throws

If an invalid type was specified

## fetchAll(type:predicate:)

Fetches all objects of a specific type which also match the predicate.

``` swift
func fetchAll<T>(type: Any.Type, predicate: NSPredicate) throws -> [T]
```

  - parameter type:      The type of which objects should be fetched

<!-- end list -->

  - parameter predicate: The predicate used for matching object to fetch

### Throws

If an invalid type was specified

### Returns

An array of matching objects

## properties(for:)

Returns an array of names of properties the given type stores persistently.

``` swift
func properties(for type: Any.Type) throws -> [String]
```

This should omit any properties returned by `relationshipsFor(type:)`.

  - parameter type: The type of which properties should be returned for

### Throws

If an invalid type was specified

### Returns

An array of property names

## relationships(for:)

Returns an array of names of properties for any relationship the given type stores persistently.

``` swift
func relationships(for type: Any.Type) throws -> [String]
```

  - parameter type: The type of which properties should be returned for

### Throws

If an invalid type was specified

### Returns

An array of property names

## save()

Performs the actual save to the persistence store.

``` swift
func save() -> Bool
```

### Throws

If any error occured during the save operation
