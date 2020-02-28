import CoreData

/// Wrapper Type to store a `NSFetchRequestResult` in
public enum ScratchPad<T: NSFetchRequestResult> {
    case object(value: T, context: NSManagedObjectContext)
    case list(value: [T], context: NSManagedObjectContext)
    case empty(NSManagedObjectContext)

    /// Proxy for the context
    public var context: NSManagedObjectContext {
        switch self {
        case let .object(_, context):
            return context
        case let .list(_, context):
            return context
        case let .empty(context):
            return context
        }
    }

    /// Proxy for the stored object. Returns the first object if used on a list, nil when empty
    public var object: T? {
        switch self {
        case let .object(object, _):
            return object
        case let .list(objects, _):
            return objects.first
        case .empty:
            return nil
        }
    }

    /// Proxy for the stored objects. Returns an empty array if empty.
    public var array: [T] {
        switch self {
        case let .object(object, _):
            return [object]
        case let .list(objects, _):
            return objects
        case .empty:
            return []
        }
    }
}

extension ScratchPad: Equatable where T: Equatable {
    public static func == (lhs: Self, rhs: Self) -> Bool {
        return lhs.context == rhs.context && lhs.array == rhs.array
    }
}
