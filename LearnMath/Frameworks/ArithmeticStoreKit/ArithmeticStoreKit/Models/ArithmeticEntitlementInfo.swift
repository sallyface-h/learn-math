//
//  ArithmeticEntitlementInfo.swift
//  ArithmeticStoreKit
//
//  Created by Jackie on 9/4/24.
//

import Foundation
import RevenueCat

public enum ArithmeticEntitlementVerificationResult {
    /// 没有验证完成
    case notRequested

    /// 已经验证
    case verified

    /// 在设备中验证
    case verifiedOnDevice

    /// 验证失败
    case failed
}

public class ArithmeticEntitlementInfos {
    /// 所有的数据
    public let all: [String: ArithmeticEntitlementInfo]
    
    /// 是否所有的元素被验证
    public let verification: ArithmeticEntitlementVerificationResult
    
    /// 原始模型
    public let originalEntitlementInfos: EntitlementInfos
    
    init(entitlementInfos: EntitlementInfos) {
        self.originalEntitlementInfos = entitlementInfos
        self.all = entitlementInfos.all.reduce([String: ArithmeticEntitlementInfo](), { partialResult, info in
            var partialResult = partialResult
            partialResult[info.key] = ArithmeticEntitlementInfo(entitlementInfo: info.value)
            return partialResult
        })
        switch entitlementInfos.verification {
        case .notRequested:
            self.verification = .notRequested
        case .verified:
            self.verification = .verified
        case .verifiedOnDevice:
            self.verification = .verifiedOnDevice
        case .failed:
            self.verification = .failed
        }
    }
}

public class ArithmeticEntitlementInfo {
    /// RevenueCat dashboard中配置的元素id
    public let id: String

    /// 用户是否有内购
    public let isActive: Bool

    /// 为true如果用户设置成续期
    public let willRenew: Bool

    /// 内购的最新购买或续订日期。
    public let latestPurchaseDate: Date?

    /// 第一次内购的时间
    public let originalPurchaseDate: Date?

    /// 过期时间，nil为终身
    public let expirationDate: Date?

    /// 产品id
    public let productId: String

    /// 是否沙盒环境
    public let isSandbox: Bool

    /// 退订的日期，可以为nil
    public let unsubscribeDetectedAt: Date?

    /// 检测到的账单问题的日期。如果为nil则为计费问题或问题已解决。
    public let billingIssueDetectedAt: Date?

    /// 是否验证
    public let verification: ArithmeticEntitlementVerificationResult

    /// 原始数据
    public let rawData: [String: Any]
    
    /// 原始模型
    public let originalEntitlementInfo: EntitlementInfo
    
    init(entitlementInfo: EntitlementInfo) {
        self.originalEntitlementInfo = entitlementInfo
        self.id = entitlementInfo.identifier
        self.isActive = entitlementInfo.isActive
        self.willRenew = entitlementInfo.willRenew
        self.latestPurchaseDate = entitlementInfo.latestPurchaseDate
        self.originalPurchaseDate = entitlementInfo.originalPurchaseDate
        self.expirationDate = entitlementInfo.expirationDate
        self.productId = entitlementInfo.productIdentifier
        self.isSandbox = entitlementInfo.isSandbox
        self.unsubscribeDetectedAt = entitlementInfo.unsubscribeDetectedAt
        self.billingIssueDetectedAt = entitlementInfo.billingIssueDetectedAt
        switch entitlementInfo.verification {
        case .notRequested:
            self.verification = .notRequested
        case .verified:
            self.verification = .verified
        case .verifiedOnDevice:
            self.verification = .verifiedOnDevice
        case .failed:
            self.verification = .failed
        }
        self.rawData = entitlementInfo.rawData
    }
}
