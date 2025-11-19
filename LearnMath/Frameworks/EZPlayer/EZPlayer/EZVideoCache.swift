import Foundation
import CryptoKit

class EZVideoCache {
    
    static let shared = EZVideoCache()
    
    private let fileManager = FileManager.default
    private let cacheDirectory: URL
    
    private init() {
        let urls = fileManager.urls(for: .cachesDirectory, in: .userDomainMask)
        cacheDirectory = urls[0].appendingPathComponent("ArithmeticVideoCaches")
        
        try? fileManager.createDirectory(at: cacheDirectory, withIntermediateDirectories: true, attributes: nil)
    }
    
    // SHA-256 哈希函数
    private func sha256(string: String, extensionPath: String) -> String {
        let inputData = Data(string.utf8)
        let hashed = SHA256.hash(data: inputData)
        return hashed.compactMap { String(format: "%02x", $0) }.joined() + ".\(extensionPath)"
    }
    
    // 缓存数据
    func cacheData(_ data: Data, forURL urlString: String, extensionPath: String = "mp4") {
        let fileName = sha256(string: urlString, extensionPath: extensionPath)
        let fileURL = cacheDirectory.appendingPathComponent(fileName)
        try? data.write(to: fileURL)
    }
    
    // 读取缓存数据
    func getCachedData(forURL urlString: String, extensionPath: String = "mp4") -> Data? {
        let fileName = sha256(string: urlString, extensionPath: extensionPath)
        let fileURL = cacheDirectory.appendingPathComponent(fileName)
        return try? Data(contentsOf: fileURL)
    }
    
    // 检查缓存是否存在
    func hasCachedData(forURL urlString: String, extensionPath: String = "mp4") -> Bool {
        let fileName = sha256(string: urlString, extensionPath: extensionPath)
        let fileURL = cacheDirectory.appendingPathComponent(fileName)
        return fileManager.fileExists(atPath: fileURL.path)
    }
    
    // 获取缓存文件的 URL
    func getCachedFileURL(forURL urlString: String, extensionPath: String = "mp4") -> URL? {
        let fileName = sha256(string: urlString, extensionPath: extensionPath)
        let fileURL = cacheDirectory.appendingPathComponent(fileName)
        return fileManager.fileExists(atPath: fileURL.path) ? fileURL : nil
    }
    
    // 清除所有缓存
    func clearAllCache() {
        try? fileManager.removeItem(at: cacheDirectory)
        try? fileManager.createDirectory(at: cacheDirectory, withIntermediateDirectories: true, attributes: nil)
    }
    
}
