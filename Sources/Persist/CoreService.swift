import Foundation
import CoreData

final public class CoreService {
    
    // MARK: - Private properties
    
    /// Name of the CoreData model
    private let modelName: String
    
    /// Whether the store should be synced to iCloud or not
    /// This will only work for >= iOS 13 or >= macOS 10.15
    private let iCloudSync: Bool
    
    /// Managed object model
    private let mom: NSManagedObjectModel
    
    /// CoreData model URL
    /// will be generated during init
    static internal var storeUrl: URL!
    
    /// Container
    private lazy var storeLocalContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: self.modelName, managedObjectModel: self.mom)
        
        let storeDescription = NSPersistentStoreDescription(url: CoreService.storeUrl)
        storeDescription.shouldMigrateStoreAutomatically = true
        storeDescription.shouldInferMappingModelAutomatically = true
        container.persistentStoreDescriptions = [storeDescription]
        
        container.loadPersistentStores { (description, error) in
            if let _error = error as NSError? {
                print("Unresolved error \(_error), \(_error.userInfo)")
            }
        }
        container.viewContext.automaticallyMergesChangesFromParent = true
        return container
    }()
    
    @available(iOS 13, OSX 10.15, *)
    /// Cloud container
    private lazy var storeCloudContainer: NSPersistentCloudKitContainer = {
        let container = NSPersistentCloudKitContainer(name: self.modelName, managedObjectModel: self.mom)
        
        let storeDescription = NSPersistentStoreDescription(url: CoreService.storeUrl)
        storeDescription.shouldMigrateStoreAutomatically = true
        storeDescription.shouldInferMappingModelAutomatically = true
        container.persistentStoreDescriptions = [storeDescription]
        
        container.loadPersistentStores { (description, error) in
            if let _error = error as NSError? {
                print("Unresolved error \(_error), \(_error.userInfo)")
            }
        }
        container.viewContext.automaticallyMergesChangesFromParent = true
        return container
    }()
    
    
    // MARK: - Public properties

    /// Actual managed object context
    public var moc: NSManagedObjectContext {
        if #available(iOS 13, OSX 10.15, *) {
            return iCloudSync ? storeCloudContainer.viewContext : storeLocalContainer.viewContext
        } else {
            return storeLocalContainer.viewContext
        }
    }
    
    
    /// CoreData handler
    public lazy var coreDataStack: CoreStack = {
        let coreDataStack = CoreStack(context: storeLocalContainer.viewContext)
        return coreDataStack
    }()
    
    
    // MARK: Init

    /// Initializes a **PersistenceService** handler
    /// - Parameters:
    ///   - bundle: Bundle name to look for the model. If no bundle name is given, the current bundle will be used
    ///   - name: Name of the CoreData model. Don't include the *.sqlite* file extension in the parameter
    public init(bundle: Bundle,
                dataModelName name: String) {
        
        //
        // get the store url
        //
        let targetDirectory: FileManager.SearchPathDirectory
        
        // decide the target directory depending on the OS
        if #available(tvOS 13, *) {
            targetDirectory = .cachesDirectory
        } else {
            targetDirectory = .documentDirectory
        }
        
        CoreService.storeUrl = FileManager.default.urls(for: targetDirectory, in: .userDomainMask).last?.appendingPathComponent("\(name).sqlite")
        
        self.modelName = name
        self.iCloudSync = false
        guard let mom = NSManagedObjectModel(contentsOf: bundle.url(forResource: name, withExtension: "momd")!
            ) else {
                fatalError("Can't init CoreData model")
        }
        self.mom = mom
    }
    
    @available(iOS 13, OSX 10.15, *)
    /// Initializes a **PersistenceService** handler
    /// - Parameters:
    ///   - bundle: Bundle name to look for the model. If no bundle name is given, the current bundle will be used
    ///   - name: Name of the CoreData model. Don't include the *.sqlite* file extension in the parameter
    ///   - syncedWithCloud: If set, the model will be synced with the Cloud
    public init(bundle: Bundle,
                dataModelName name: String,
                syncedWithCloud isCloud: Bool = false) {
        // get the store url
        CoreService.storeUrl = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).last?.appendingPathComponent("\(name).sqlite")
        self.modelName = name
        self.iCloudSync = isCloud
        guard let mom = NSManagedObjectModel(contentsOf: bundle.url(forResource: name, withExtension: "momd")!
            ) else {
                fatalError("Can't init CoreData model")
        }
        self.mom = mom
    }
}
