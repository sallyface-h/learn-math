//
//  ArithmeticProduct.swift
//  Alamofire
//
//  Created by Jackie on 9/3/24.
//

import Foundation
import RevenueCat

public enum ArithmeticProductCategory {
    /// 不是订阅
    case nonsubscription
    /// 是订阅
    case subscription
}

public enum ArithmeticProductType {
    /// 可消耗
    case consumable
    /// 不可消耗
    case nonConsumable
    /// 非自动续费订阅
    case nonRenewableSubscription
    /// 自动续费订阅
    case autoRenewableSubscription
}

public class ArithmeticProduct {
    /// id
    public let id: String
    
    /// 类别
    public let category: ArithmeticProductCategory
    
    /// 类型
    public let type: ArithmeticProductType
    
    /// 价格
    public let price: String
    
    /// 原始数据
    public let originalProduct: StoreProduct
    
    public init(product: StoreProduct) {
        self.originalProduct = product
        self.id = product.productIdentifier
        
        switch product.productCategory {
        case .subscription:
            self.category = .subscription
        case .nonSubscription:
            self.category = .nonsubscription
        }
        
        switch product.productType {
        case .consumable:
            self.type = .consumable
        case .nonConsumable:
            self.type = .nonConsumable
        case .nonRenewableSubscription:
            self.type = .nonRenewableSubscription
        case .autoRenewableSubscription:
            self.type = .autoRenewableSubscription
        }
        
        self.price = product.localizedPriceString
    }
}
