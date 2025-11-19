//
//  UIControl+Egg.swift
//  EmperorKit_Example
//
//  Created by 黄杰 on 2021/3/6.
//  Copyright © 2021 3commas. All rights reserved.
//

import UIKit

extension UIControl {
    
    @objc func removeButtonHighlightedAction(_ sender: UIButton) {
        if sender.isHighlighted {
            sender.isHighlighted = false
        }
    }
}

extension AppearanceX where Base: UIControl {
    
    public func removeHighlighted() {
        base.addTarget(base, action: #selector(base.removeButtonHighlightedAction(_:)), for: .allEvents)
    }
}
