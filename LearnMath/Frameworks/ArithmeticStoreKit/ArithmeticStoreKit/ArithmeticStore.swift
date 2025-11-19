//
//  ArithmeticStore.swift
//  ArithmeticStoreKit
//
//  Created by Jackie on 9/3/24.
//

import Foundation
import RevenueCat
import AppToolKit

public protocol ArithmeticStoreDelegate: NSObjectProtocol {
    /// 数据更新
    func store(_ store: ArithmeticStore, receivedUpdated customerInfo: ArithmeticCustomerInfo)
}

public class ArithmeticStore: NSObject {
    
    public static let shared: ArithmeticStore = ArithmeticStore()
    
    public var info: ArithmeticCustomerInfo?
    
    public var hadCachedPackages: Bool {
        let cached = Purchases.shared.cachedOfferings?.current?.availablePackages ?? []
        return !cached.isEmpty
    }
    
    public var cachedPackages: [ArithmeticPackage] {
        let cached = Purchases.shared.cachedOfferings?.current?.availablePackages ?? []
        return cached.compactMap { ArithmeticPackage(package: $0) }
    }
    
    public weak var delegate: ArithmeticStoreDelegate?
    
    public static let TAG: String = "ArithmeticStore"
    
    private override init() {
        super.init()
    }
    
}

// MARK: - Public

public extension ArithmeticStore {
    
    func register() {
        Purchases.configure(withAPIKey: "appl_BLWATyvYuRiBJEUgGYRhTCJZdHz")
        
        if let info = Purchases.shared.cachedCustomerInfo {
            self.info = ArithmeticCustomerInfo(info: info)
        }
        Purchases.shared.delegate = self
    }
    
    /// 获取包裹
    @MainActor
    func fetchPackages() async throws -> [ArithmeticPackage] {
        try await withCheckedThrowingContinuation { continuation in
            if !Purchases.isConfigured {
                continuation.resume(throwing: ArithmeticStoreError.revenueCatNotInit)
                return
            }
            Purchases.shared.getOfferings { offering, error in
                if let error = error {
                    continuation.resume(throwing: error)
                } else {
                    let packages = (offering?.current?.availablePackages ?? []).compactMap { ArithmeticPackage(package: $0) }
                    continuation.resume(returning: packages)
                }
            }
        }
    }
    
    /// 购买
    @MainActor
    func purchase(package: ArithmeticPackage) async throws -> (transaction: ArithmeticTransaction, customerInfo: ArithmeticCustomerInfo) {
        try await withCheckedThrowingContinuation { [weak self] continuation in
            if !Purchases.isConfigured {
                continuation.resume(throwing: ArithmeticStoreError.revenueCatNotInit)
                return
            }
            Purchases.shared.purchase(package: package.originalPackage) { [weak self] transaction, customerInfo, error, userCancelled in
                if let error = error {
                    continuation.resume(throwing: error)
                } else {
                    if let transaction = transaction, let customerInfo = customerInfo {
                        let info = ArithmeticCustomerInfo(info: customerInfo)
                        self?.info = info
                        continuation.resume(returning: (transaction: ArithmeticTransaction(storeTransaction: transaction), customerInfo: info))
                    } else {
                        continuation.resume(throwing: ArithmeticStoreError.returnErrorResults(transaction, customerInfo))
                    }
                }
            }
        }
    }
    
    /// 恢复购买
    @MainActor
    func restore() async throws -> ArithmeticCustomerInfo {
        try await withCheckedThrowingContinuation { [weak self] continuation in
            if !Purchases.isConfigured {
                continuation.resume(throwing: ArithmeticStoreError.revenueCatNotInit)
                return
            }
            Purchases.shared.restorePurchases { [weak self] customerInfo, error in
                if let error = error {
                    continuation.resume(throwing: error)
                } else {
                    if let customerInfo = customerInfo {
                        let info = ArithmeticCustomerInfo(info: customerInfo)
                        self?.info = info
                        continuation.resume(returning: info)
                    } else {
                        continuation.resume(throwing: ArithmeticStoreError.returnErrorResults(nil, customerInfo))
                    }
                }
            }
        }
    }
    
    /// 获取用户状态
    @MainActor
    func getCustomerInfo() async throws -> ArithmeticCustomerInfo {
        let info = try await Purchases.shared.customerInfo()
        let finalInfo = ArithmeticCustomerInfo(info: info)
        self.info = finalInfo
        return finalInfo
    }
    
}

// MARK: - PurchasesDelegate

extension ArithmeticStore: PurchasesDelegate {
    
    /// 接收到更新
    public func purchases(_ purchases: Purchases, receivedUpdated customerInfo: CustomerInfo) {
        let info = ArithmeticCustomerInfo(info: customerInfo)
        self.info = info
        delegate?.store(self, receivedUpdated: info)
    }
    
}
