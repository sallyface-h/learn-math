//
//  AppStoreCacheUtil.swift
//  AppStoreKit_Example
//
//  Created by Jackie on 8/18/24.
//  Copyright © 2024 3commas. All rights reserved.
//

import Foundation
import WebKit
import AppToolKit

public struct AppStoreCacheUtil {
    
    private let TAG: String = "AppStoreCacheUtil"
    
    public init() {
        
    }
    
}

// MARK: - Public

public extension AppStoreCacheUtil {
    
    func calculateCacheSize(completion: ((_ sizeStr: String) -> Void)?) {
        let fileManager = FileManager.default
        
        var cacheSize: Int64 = 0
        // 计算视频缓存大小
        if let url = fileManager.urls(for: .cachesDirectory, in: .userDomainMask).first {
            let videoCacheDirectory = url.appendingPathComponent("ArithmeticVideoCaches")
            cacheSize += calculateSize(for: videoCacheDirectory)
        }
        
        // 计算web的缓存大小
        calculateWebCacheSize { size in
            cacheSize += size
            let sizeStr = formatFileSize(size: cacheSize)
            DispatchQueue.main.async {
                completion?(sizeStr)
            }
        }
    }
    
    func clearCaches(completion: (() -> Void)?) {
        let fileManager = FileManager.default
        
        // 清除视频缓存大小
        let urls = fileManager.urls(for: .cachesDirectory, in: .userDomainMask)
        let videoCacheDirectory = urls[0].appendingPathComponent("ArithmeticVideoCaches")
        
        do {
            try fileManager.removeItem(at: videoCacheDirectory)
        } catch {
            info_print(TAG, message: "\(videoCacheDirectory)路径下的删除失败")
        }
        
        // 清除web的大小
        clearWebViewCache {
            info_print(TAG, message: "清除web的缓存成功")
            DispatchQueue.main.async {
                completion?()
            }
        }
    }
    
}

// MARK: - Private

private extension AppStoreCacheUtil {
    
    func calculateSize(for directory: URL) -> Int64 {
        let fileManager = FileManager.default
        guard let enumerator = fileManager.enumerator(at: directory, includingPropertiesForKeys: [.fileSizeKey], options: []) else {
            return 0
        }
        
        var totalSize: UInt = 0
        
        for case let fileURL as URL in enumerator {
            guard let attributes = try? fileManager.attributesOfItem(atPath: fileURL.path) else { continue }
            let fileSize = attributes[.size] as? UInt ?? 0
            totalSize += fileSize
        }
        
        return Int64(totalSize)
    }
    
    func calculateWebCacheSize(completion: @escaping (Int64) -> Void) {
        WKWebsiteDataStore.default().fetchDataRecords(ofTypes: WKWebsiteDataStore.allWebsiteDataTypes()) { records in
            let size = records.reduce(0) { total, record in
                // 使用 displayName 的长度作为近似大小，每个字符按1字节计算
                return total + Int64(record.displayName.utf8.count)
            }
            completion(size)
        }
    }
    
    func calculateWebCacheSizeSync() -> Int64 {
        let semaphore = DispatchSemaphore(value: 0)
        var cacheSize: Int64 = 0
        
        calculateWebCacheSize { size in
            cacheSize = size
            semaphore.signal()
        }
        
        semaphore.wait()
        return cacheSize
    }

    func formatFileSize(size: Int64) -> String {
        let units = ["bytes", "KB", "MB", "GB", "TB", "PB", "EB", "ZB", "YB"]
        var size = Double(size)
        var unitIndex = 0
        
        while size >= 1024 && unitIndex < units.count - 1 {
            size /= 1024
            unitIndex += 1
        }
        
        let formattedSize = String(format: "%.0f", size)
        return "\(formattedSize) \(units[unitIndex])"
    }
    
    func clearWebViewCache(completion: @escaping () -> Void) {
        WKWebsiteDataStore.default().removeData(ofTypes: WKWebsiteDataStore.allWebsiteDataTypes(), modifiedSince: Date(timeIntervalSince1970: 0)) {
            completion()
        }
    }
    
}
