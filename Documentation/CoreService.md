# CoreService

``` swift
final public class CoreService
```

## Initializers

## init(bundle:dataModelName:)

Initializes a **PersistenceService** handler

``` swift
public init(bundle: Bundle, dataModelName name: String)
```

### Parameters

  - bundle: Bundle name to look for the model. If no bundle name is given, the current bundle will be used
  - name: Name of the CoreData model. Don't include the *.sqlite* file extension in the parameter

## init(bundle:dataModelName:syncedWithCloud:)

``` swift
@available(iOS 13, OSX 10.15, *) public init(bundle: Bundle, dataModelName name: String, syncedWithCloud isCloud: Bool = false)
```

## Properties

## moc

Actual managed object context

``` swift
var moc: NSManagedObjectContext
```

## coreDataStack

CoreData handler

``` swift
var coreDataStack: CoreStack = {
        let coreDataStack = CoreStack(context: storeLocalContainer.viewContext)
        return coreDataStack
    }()
```
