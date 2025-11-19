//
//  UINavigationItem+Egg.swift
//  EmperorKit_Example
//
//  Created by 黄杰 on 2021/3/1.
//  Copyright © 2021 3commas. All rights reserved.
//

import UIKit

public extension UINavigationItem {
    
    func addLeftViews(views: UIView..., itemSpacing: CGFloat = 0.0) {
        let stackView = UIStackView()
        stackView.alignment = .center
        stackView.spacing = itemSpacing
        stackView.axis = .horizontal
        stackView.distribution = .fill
        
        for view in views {
            stackView.addArrangedSubview(view)
        }
        
        self.leftBarButtonItem = UIBarButtonItem(customView: stackView)
    }
    
    func addRightViews(views: UIView..., itemSpacing: CGFloat = 0.0) {
        let stackView = UIStackView()
        stackView.alignment = .center
        stackView.spacing = itemSpacing
        stackView.axis = .horizontal
        stackView.distribution = .fill
        
        for view in views {
            stackView.addArrangedSubview(view)
        }
        
        self.rightBarButtonItem = UIBarButtonItem(customView: stackView)
    }
}
