//
//  ArithmeticCustomerInfo.swift
//  ArithmeticStoreKit
//
//  Created by Jackie on 9/3/24.
//

import Foundation
import RevenueCat

public class ArithmeticCustomerInfo {
    
    /// 所有的元素
    public let entitlements: ArithmeticEntitlementInfos
    
    /// 所有激活订阅的日期
    public let activeSubscriptions: Set<String>
    
    /// 所有已经购买的商品id
    public let allPurchasedProductId: Set<String>
    
    /// 最新到期日期
    public let latestExpirationDate: Date?
    
    /// 是否有内购
    public var isPurchased: Bool {
        return self.activeSubscriptions.count > 0
    }
    
    /// 原始模型
    public let originalCustomerInfo: CustomerInfo
    
    init(info: CustomerInfo) {
        self.originalCustomerInfo = info
        self.entitlements = ArithmeticEntitlementInfos(entitlementInfos: info.entitlements)
        self.activeSubscriptions = info.activeSubscriptions
        self.allPurchasedProductId = info.allPurchasedProductIdentifiers
        self.latestExpirationDate = self.activeSubscriptions.count > 0 ? info.latestExpirationDate : nil
    }
}
