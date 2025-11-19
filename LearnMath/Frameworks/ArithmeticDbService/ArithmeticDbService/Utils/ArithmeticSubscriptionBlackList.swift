//
//  ArithmeticSubscriptionBlackList.swift
//  ArithmeticStoreKit
//
//  Created by Jackie on 9/5/24.
//

import Foundation
import ArithmeticStoreKit
import Mediator
import Mediator_MathCashier
import AppStoreKit
import ArithmeticKit

public struct ArithmeticSubscriptionBlackList {
    
    /// 技能黑名单（需要订阅才能访问）
    public static let skillBlackList: [String] = [
        /// 加法-凑十法
        "F64BED24CE4749FEB81804FA60B10236",
        /// 加法-拆补法
        "A90EDF1218214BFDA8A717BB4EDD4D67",
        /// 加法-带符号搬家
        "AF5ABCC3261B404DA71666C7531BCEFF",
        /// 加法-找基数
        "878501A9F1AE4D1D801300BDA1F023D4",
        
        /// 减法-破十法
        "4EE51F8669BB42859AE7722325065B2F",
        /// 减法-带符号搬家
        "381F8AB26E2B412FAB945331A33B8133",
        /// 减法-凑整法
        "5ADFC61A133A4FA383B1A7E4A949AD31",
        /// 减法-拆项法
        "54C6FAE0A13040218988D4E9F8CDD898",
        
        /// 乘法-竖式
        "D037D4172A2041A09630D594F8C2D9FC",
        /// 乘法-双位尾数为1相乘
        "DD0C9AD669BA457F9172DAC819DA1D21",
        /// 乘法-拆项法
        "7E3911225A4D4DB18AA8FA8B723D66CB",
        /// 乘法-乘5或25技巧
        "9F1563EE32494756A163BA4B50956225",
        
        /// 除法-竖式
        "37D16855268A4406B7A592CD3196C9B3",
        /// 除法-除5或25技巧
        "50FE9A5FD881442590BD253BB23C793A",
        /// 除法-拆项法
        "446B1946CCE7473096755B64F1AA7AA1",
    ]
    
    /// 是有权利访问
    public static func hasAuthority(selectedSkillId: String? = nil) -> Bool {
        if ArithmeticStore.shared.info?.isPurchased ?? false {
            // 已经订阅过，有权限访问
            return true
        } else {
            // 判断是否在24小时间隔，如果在24小时以内，则可以跳过订阅
            let skipTime = AppStoreKit.skipAppPurchaseTime()
            let currentTime = Date().timeIntervalSince1970
            let timeDifference = currentTime - skipTime
            if timeDifference > 0 {
                let hoursDifference = timeDifference / 3600
                let in24Hours = hoursDifference <= 24
                if in24Hours {
                    return true
                } else {
                    if let selectedSkillId = selectedSkillId {
                        let isContains = skillBlackList.contains(selectedSkillId)
                        return !isContains
                    } else {
                        return false
                    }
                }
            } else {
                if let selectedSkillId = selectedSkillId {
                    let isContains = skillBlackList.contains(selectedSkillId)
                    return !isContains
                } else {
                    return false
                }
            }
        }
    }
    
    /// 打开收银台
    public static func openCashier(isPresent: Bool = true, source: UIViewController, viewSource: ArithmeticTrackersSubscriptionSource, animated: Bool = true) {
        // 打开订阅界面
        if isPresent {
            guard let mathCashierNav = Mediator.shared.mathCashier.mathSubscriptionViewControllerWithNav(source: viewSource) else { return }
            source.present(mathCashierNav, animated: animated)
        } else {
            guard let mathCashier = Mediator.shared.mathCashier.mathSubscriptionViewController(source: viewSource) else { return }
            source.navigationController?.pushViewController(mathCashier, animated: animated)
        }
    }
    
}
