//
//  DCFoundation
//

import Foundation

public func FileExistsAt(path: String) -> Bool {
    var isDir: ObjCBool = false
    return FileManager.default.fileExists(atPath: path, isDirectory: &isDir) && !isDir.boolValue
}

public func DirectoryExistsAt(path: String) -> Bool {
    var isDir: ObjCBool = false
    return FileManager.default.fileExists(atPath: path, isDirectory: &isDir) && isDir.boolValue
}

@discardableResult public func DirectoryCreateAt(path: String) -> Bool {
    do {
        try FileManager.default.createDirectory(atPath: path, withIntermediateDirectories: true, attributes: nil)
        return true
    } catch {
        print(error)
    }
    return false
}

public func DirectoryContentsAt(path: String) -> [String]? {
    var contents: [String]?
    do {
        contents = try FileManager.default.contentsOfDirectory(atPath: path)
    } catch {
        print(error)
    }
    return contents
}

func HomeDirectory(folder: String, file: String? = nil) -> String {
    let path = NSHomeDirectory().appending(pathComponent: folder)
    if let file = file {
        return path.appending(pathComponent: file)
    }
    return path
}

public func DocumentsDirectory(file: String? = nil) -> String {
    return HomeDirectory(folder: "Documents", file: file)
}

public func DocumentsURL(file: String? = nil) -> URL? {
    return URL(fileURLWithPath: DocumentsDirectory(file: file))
}

public func CacheDirectory(file: String? = nil) -> String {
    return HomeDirectory(folder: "Library/Caches", file: file)
}

public func CacheURL(file: String? = nil) -> URL? {
    return URL(fileURLWithPath: CacheDirectory(file: file))
}

public func TempDirectory(file: String? = nil) -> String {
    return HomeDirectory(folder: "tmp", file: file)
}

public func TempURL(file: String? = nil) -> URL? {
    return URL(fileURLWithPath: TempDirectory(file: file))
}
