//
//  ArithmeticTransaction.swift
//  ArithmeticStoreKit
//
//  Created by Jackie on 9/3/24.
//

import Foundation
import RevenueCat

public class ArithmeticTransaction {
    /// 产品id
    public let productId: String
    
    /// 订阅时长
    public let purchaseDate: Date
    
    /// 交易id
    public let transactionId: String
    
    /// 购买数量
    public let quantity: Int
    
    /// 原始数据
    public let originalTransaction: StoreTransaction
    
    init(storeTransaction: StoreTransaction) {
        self.originalTransaction = storeTransaction
        self.productId = storeTransaction.productIdentifier
        self.purchaseDate = storeTransaction.purchaseDate
        self.transactionId = storeTransaction.transactionIdentifier
        self.quantity = storeTransaction.quantity
    }
}
