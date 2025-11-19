//
//  UIView+Egg.swift
//  EggKit
//
//  Created by Limon on 11/14/16.
//  Copyright © 2016 egg. All rights reserved.
//

import UIKit

public enum GradientDirection {
    case topToBottom
    case leftToRight
    case topLeftToBottomRight
    case topRightToBottomLeft
}

extension AppearanceX where Base: UIView {

    public var responderViewController: UIViewController? {
        var parentResponder: UIResponder? = self.base
        while parentResponder != nil {
            parentResponder = parentResponder?.next
            if let viewController = parentResponder as? UIViewController {
                return viewController
            }
        }
        return nil
    }
    
    public func roundCorners(corners: UIRectCorner, radius: CGFloat, rect: CGRect = .zero) {
        let path = UIBezierPath(roundedRect: rect != .zero ? rect : base.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        base.layer.mask = mask
    }
    
    public func applyGradient(colors: [UIColor],
                           direction: GradientDirection = .topToBottom,
                           locations: [NSNumber]? = nil,
                               rect: CGRect = .zero,
                       cornerRadius: CGFloat = 0.0) {
            
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = rect == .zero ? base.bounds : rect
        gradientLayer.colors = colors.map { $0.cgColor }
        gradientLayer.cornerRadius = cornerRadius
        
        if let locations = locations {
            gradientLayer.locations = locations
        }
        
        switch direction {
        case .topToBottom:
            gradientLayer.startPoint = CGPoint(x: 0.5, y: 0)
            gradientLayer.endPoint = CGPoint(x: 0.5, y: 1)
        case .leftToRight:
            gradientLayer.startPoint = CGPoint(x: 0, y: 0.5)
            gradientLayer.endPoint = CGPoint(x: 1, y: 0.5)
        case .topLeftToBottomRight:
            gradientLayer.startPoint = CGPoint(x: 0, y: 0)
            gradientLayer.endPoint = CGPoint(x: 1, y: 1)
        case .topRightToBottomLeft:
            gradientLayer.startPoint = CGPoint(x: 1, y: 0)
            gradientLayer.endPoint = CGPoint(x: 0, y: 1)
        }
        
        // Remove any existing gradient layers
        base.layer.sublayers?.removeAll { $0 is CAGradientLayer }
        
        // Add the new gradient layer
        base.layer.insertSublayer(gradientLayer, at: 0)
    }
    
}

extension UIView {
    
    public var e_left: CGFloat {
        set {
            var frame = self.frame
            frame.origin.x = newValue
            self.frame = frame
        }
        get {
            return self.frame.origin.x
        }
    }
    
    public var e_right: CGFloat {
        set {
            var frame = self.frame
            frame.origin.x = newValue - frame.size.width
            self.frame = frame
        }
        get {
            return self.frame.origin.x + self.frame.size.width
        }
    }
    
    public var e_top: CGFloat {
        set {
            var frame = self.frame
            frame.origin.y = newValue
            self.frame = frame
        }
        get {
            return self.frame.origin.y
        }
    }
    
    public var e_bottom: CGFloat {
        set {
            var frame = self.frame
            frame.origin.y = newValue - frame.size.height
            self.frame = frame
        }
        get {
            return self.frame.origin.y + self.frame.size.height
        }
    }
    
    public var e_centerX: CGFloat {
        set {
            self.center = CGPoint(x: newValue, y: self.center.y)
        }
        get {
            return self.center.x
        }
    }
    
    public var e_centerY: CGFloat {
        set {
            self.center = CGPoint(x: self.center.x, y: newValue)
        }
        get {
            return self.center.y
        }
    }
    
    public var e_width: CGFloat {
        set {
            var frame = self.frame
            frame.size.width = newValue
            self.frame = frame
        }
        get {
            return self.frame.width
        }
    }
    
    public var e_height: CGFloat {
        set {
            var frame = self.frame
            frame.size.height = newValue
            self.frame = frame
        }
        get {
            return self.frame.height
        }
    }
    
    public var e_origin: CGPoint {
        set {
            var frame = self.frame
            frame.origin = newValue
            self.frame = frame
        }
        get {
            return self.frame.origin
        }
    }
    
    public var e_size: CGSize {
        set {
            var frame = self.frame
            frame.size = newValue
            self.frame = frame
        }
        get {
            return self.frame.size
        }
    }
}

extension AppearanceX where Base: UIView & NibReusable {

    public static func loadFromNib() -> Base {
        return Base.nib.instantiate(withOwner: nil, options: nil)[0] as! Base
    }

    public static func loadFromNib(owner: Any) -> UIView {
        return Base.nib.instantiate(withOwner: owner, options: nil)[0] as! UIView
    }
}
