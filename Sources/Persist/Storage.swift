import Foundation

/// Store Decodables to disk
public class Storage {
    /// Error if a Storage operation failed
    public enum StorageError: Error {
        case error(_ message:String)
    }

    /// Supported directories
    public enum Directory {
        case documents
        case caches
    }

    //MARK: - Functions
    /** Store an encodable struct to the specified directory on disk
     *  @param object      The encodable struct to store
     *  @param directory   Where to store the struct
     *  @param fileName    What to name the file where the struct data will be stored
     **/
    public static func store<T: Encodable>(_ object: T, to directory: Directory, as fileName: String) throws {
        let url = getURL(for: directory).appendingPathComponent(fileName, isDirectory: false)
        let encoder = JSONEncoder()

        do {
            let data = try encoder.encode(object)
            if FileManager.default.fileExists(atPath: url.path) {
                try FileManager.default.removeItem(at: url)
            }
            FileManager.default.createFile(atPath: url.path, contents: data, attributes: nil)
        } catch {
            throw(error)
        }
    }

    /** Retrieve and convert an Object from a file on disk
     *  @param fileName    Name of the file where struct data is stored
     *  @param directory   Directory where Object data is stored
     *  @param type        Object type (i.e. Message.self)
     *  @return decoded    Object model(s) of data
     **/
    public static func retrieve<T: Decodable>(_ fileName: String, from directory: Directory, as type: T.Type) throws -> T {
        let url = getURL(for: directory).appendingPathComponent(fileName, isDirectory: false)

        if !FileManager.default.fileExists(atPath: url.path) {
            throw StorageError.error("No data at location: \(url.path)")
        }

        if let data = FileManager.default.contents(atPath: url.path) {
            let decoder = JSONDecoder()
            do {
                let model = try decoder.decode(type, from: data)
                return model
            } catch {
                throw(error)
            }
        } else {
            throw StorageError.error("No data at location: \(url.path)")
        }
    }

    /** Remove all files at specified directory */
    public static func clear(_ directory: Directory) throws {

        let url = getURL(for: directory)
        do {
            let contents = try FileManager.default.contentsOfDirectory(at: url, includingPropertiesForKeys: nil, options: [])
            for fileUrl in contents {
                try FileManager.default.removeItem(at: fileUrl)
            }
        } catch {
            throw(error)
        }

    }

    /** Remove specified file from specified directory */
    public static func remove(_ fileName: String, from directory: Directory) throws {
        let url = getURL(for: directory).appendingPathComponent(fileName, isDirectory: false)
        if FileManager.default.fileExists(atPath: url.path) {
            do {
                try FileManager.default.removeItem(at: url)
            } catch {
                throw(error)
            }
        }
    }


    /** Returns BOOL indicating whether file exists at specified directory with specified file name */
    static fileprivate func fileExists(_ fileName: String, in directory: Directory) -> Bool {
        let url = getURL(for: directory).appendingPathComponent(fileName, isDirectory: false)
        return FileManager.default.fileExists(atPath: url.path)
    }

    /** Returns URL constructed from specified directory */
    static fileprivate func getURL(for directory: Directory) -> URL {
        var searchPathDirectory: FileManager.SearchPathDirectory

        switch directory {
        case .documents:
            searchPathDirectory = .documentDirectory
        case .caches:
            searchPathDirectory = .cachesDirectory
        }

        if let url = FileManager.default.urls(for: searchPathDirectory, in: .userDomainMask).first {
            return url
        } else {
            fatalError("Could not create URL for specified directory.")
        }
    }
}
