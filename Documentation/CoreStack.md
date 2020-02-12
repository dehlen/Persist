# CoreStack

``` swift
public final class CoreStack: PersistenceStore
```

## Inheritance

[`PersistenceStore`](PersistenceStore)

## Initializers

## init(context:)

Initialize a new CoreData persistence store

``` swift
public init(context: NSManagedObjectContext)
```

  - parameter context: The managed object context used for querying and

### Returns

An initialised instance of this class

## Methods

## fetchRequest(for:predicate:)

Fetch request for any type

``` swift
public func fetchRequest(for type: Any.Type, predicate: NSPredicate) throws -> NSFetchRequest<NSFetchRequestResult>
```

### Parameters

  - type: Type to fetch
  - predicate: Predicate

## fetchRequest(for:sortedBy:)

Fetch request for any type

``` swift
public func fetchRequest(for type: Any.Type, sortedBy sortDescriptor: NSSortDescriptor) throws -> NSFetchRequest<NSFetchRequestResult>
```

### Parameters

  - type: Type to fetch
  - predicate: Predicate

## create(type:)

Create a new object of the given type.

``` swift
public func create<T>(type: Any.Type) throws -> T
```

  - parameter type: The type of which a new object should be created

### Throws

If a invalid type was specified

### Returns

A newly created object of the given type

## delete(type:predicate:)

Delete objects of the given type which also match the predicate.

``` swift
public func delete(type: Any.Type, predicate: NSPredicate) throws
```

  - parameter type:      The type of which objects should be deleted

<!-- end list -->

  - parameter predicate: The predicate used for matching objects to delete

### Throws

If an invalid type was specified

## fetchAll(type:predicate:)

Fetches all objects of a specific type which also match the predicate.

``` swift
public func fetchAll<T>(type: Any.Type, predicate: NSPredicate) throws -> [T]
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
public func properties(for type: Any.Type) throws -> [String]
```

This should omit any properties returned by `relationshipsFor(type:)`.

  - parameter type: The type of which properties should be returned for

### Throws

If an invalid type was specified

### Returns

An array of property names representing system native types.

## relationships(for:)

Returns an array of property names for any relationship the given type stores persistently.

``` swift
public func relationships(for type: Any.Type) throws -> [String]
```

  - parameter type: The type of which properties should be returned for

### Throws

If an invalid type was specified

### Returns

An array of property names representing related entities.

## save()

Performs the actual save to the persistence store.

``` swift
@discardableResult public func save() -> Bool
```

### Throws

If any error occured during the save operation

## performBlock(block:)

``` swift
public func performBlock(block: @escaping () -> Void)
```

## performAndWait(block:)

``` swift
public func performAndWait(block: @escaping () -> Void)
```
