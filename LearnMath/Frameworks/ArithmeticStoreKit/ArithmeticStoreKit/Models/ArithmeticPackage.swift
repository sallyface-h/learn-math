//
//  ArithmeticPackage.swift
//  Alamofire
//
//  Created by Jackie on 9/3/24.
//

import Foundation
import RevenueCat

public enum ArithmeticPackageType {
    // 每周
    case weekly
    // 每月
    case monthly
    // 两个月
    case twoMonth
    // 季度
    case quarterly
    // 六个月
    case sixMonth
    // 每年
    case annual
    // 终身
    case lifetime
    // 未知
    case unknown(str: String)
    
    public var dayStr: String {
        switch self {
        case .weekly:
            return "Weekly"
        case .monthly:
            return "Monthly"
        case .twoMonth:
            return "TwoMonth"
        case .quarterly:
            return "Quarterly"
        case .sixMonth:
            return "SixMonth"
        case .annual:
            return "Annual"
        case .lifetime:
            return "Lifetime"
        case .unknown(let str):
            return "Unknown"
        }
    }
    
}

public class ArithmeticPackage {
    /// 包裹id
    public let id: String
    
    /// 类型
    public let type: ArithmeticPackageType
    
    /// 产品
    public let product: ArithmeticProduct
    
    /// 原始数据
    public let originalPackage: Package
    
    public init(package: Package) {
        self.originalPackage = package
        self.id = package.identifier
        
        switch package.packageType {
        case .weekly:
            self.type = .weekly
        case .monthly:
            self.type = .monthly
        case .twoMonth:
            self.type = .twoMonth
        case .threeMonth:
            self.type = .quarterly
        case .sixMonth:
            self.type = .sixMonth
        case .annual:
            self.type = .annual
        case .lifetime:
            self.type = .lifetime
        default:
            self.type = .unknown(str: String(describing: package.packageType))
        }
        
        self.product = ArithmeticProduct(product: package.storeProduct)
    }
}
