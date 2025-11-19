//
//  PopUpUIConfig.swift
//  ArithmeticKit
//
//  Created by Jackie on 8/2/24.
//

import Foundation

public protocol PopUpViewable: UIView {
    var rootView: PopUpView? { get set }
    
    func bind(_ view: PopUpView)
}

public struct PopUpUIConfig {
    /// contentView距离顶部的高度
    public var contentViewTopY: CGFloat
    /// contentView高度
    public var contentViewHeight: CGFloat
    
    public init(contentViewTopY: CGFloat, contentViewHeight: CGFloat) {
        self.contentViewTopY = contentViewTopY
        self.contentViewHeight = contentViewHeight
    }
}
