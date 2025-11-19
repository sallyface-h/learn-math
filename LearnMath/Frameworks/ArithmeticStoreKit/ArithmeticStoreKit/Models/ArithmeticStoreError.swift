//
//  ArithmeticStoreError.swift
//  ArithmeticStoreKit
//
//  Created by Jackie on 9/3/24.
//

import Foundation
import RevenueCat

public enum ArithmeticStoreError: Error, CustomStringConvertible {
    /// RevenueCat没有init成功
    case revenueCatNotInit
    /// 返回的参数不正确
    case returnErrorResults(_ transaction: StoreTransaction?, _ info: CustomerInfo?)
    
    public var description: String {
        switch self {
        case .revenueCatNotInit:
            return "RevenueCat没有init成功"
        case .returnErrorResults(let transaction, let info):
            return "参数没有返回 transaction：\(transaction?.description ?? ""), info: \(info?.description ?? "")"
        }
    }
}
