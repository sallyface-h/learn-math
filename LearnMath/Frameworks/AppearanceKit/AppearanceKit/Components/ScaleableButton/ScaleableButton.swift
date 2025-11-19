//
//  ScaleableButton.swift
//  EmperorKit_Example
//
//  Created by 3commas on 3/5/21.
//  Copyright © 2021 3commas. All rights reserved.
//

import UIKit
import AppToolKit
import AudioToolbox
import AppStoreKit

open class ScaleableButton: UIButton {

    public var carryValue: Any?
    
    public var shouldPlaySound: Bool = true
    
    public var shouldHaptics: Bool = true
    
    public var enableAnimation: Bool = true
    
    public var startAnimationAction: (() -> Void)?
    public var stopAnimationAction: (() -> Void)?
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        self.adjustsImageWhenHighlighted = false
        self.isMultipleTouchEnabled = false
        self.addTarget(self, action: #selector(btnClick(_ :)), for: .touchUpInside)
    }

    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    public var touchScale: CGFloat = 0.9

    public var animationDuration: TimeInterval = 0.05

    private var isAnimation: Bool = false
    private var action: ((_ btn: UIButton) -> Void)?

    @objc private func btnClick(_ btn: UIButton) {
        action?(self)
    }

    @objc private func buttonAction() {
        action?(self)
    }

    override open var isHighlighted: Bool {
        didSet {
            if self.touchScale != 1.0 && enableAnimation {
                self.updateState()
            }
        }
    }

    private func updateState() {
        if self.isHighlighted {
            self.startAnimation()
        } else {
            if !self.isAnimation {
                self.stopAnimation()
            }
        }
    }

    public func startAnimation() {
        self.isAnimation = true
        startAnimationAction?()
        UIView.animate(withDuration: self.animationDuration, delay: 0.0, options: .curveEaseInOut, animations: { [weak self] in
            if let sSelf = self {
                self?.transform = CGAffineTransform(scaleX: sSelf.touchScale, y: sSelf.touchScale)
            }
        }, completion: { [weak self] finished in
            self?.isAnimation = false
            if !(self?.isHighlighted ?? false) {
                self?.stopAnimation()
            }
        })
    }

    public func stopAnimation() {
        stopAnimationAction?()
        UIView.animate(withDuration: self.animationDuration, delay: 0.0, options: .curveEaseInOut, animations: { [weak self] in
            self?.transform = .identity
        }, completion: nil)
    }
    
    open override func addTarget(_ target: Any?, action: Selector, for controlEvents: UIControl.Event) {
        super.addTarget(target, action: action, for: controlEvents)
    }
    
    open override func sendActions(for controlEvents: UIControl.Event) {
//        delay(0.06) {
//            super.sendActions(for: controlEvents)
//        }
        // 播放音效
        if shouldPlaySound && !AppStoreKit.isSoundEffectsDisable() {
            SoundPlayer.shared.playSound(type: .btnClick)
        }
        // 震动
        if shouldHaptics && !AppStoreKit.isHapticsDisable() {
            HapticFeedbackManager.impact(style: .light)
        }
        super.sendActions(for: controlEvents)
    }
    
    open override func sendAction(_ action: Selector, to target: Any?, for event: UIEvent?) {
//        delay(0.06) {
//            super.sendAction(action, to: target, for: event)
//        }
        // 播放音效
        if shouldPlaySound && !AppStoreKit.isSoundEffectsDisable() {
            SoundPlayer.shared.playSound(type: .btnClick)
        }
        // 震动
        if shouldHaptics && !AppStoreKit.isHapticsDisable() {
            HapticFeedbackManager.impact(style: .light)
        }
        super.sendAction(action, to: target, for: event)
    }
    
    open override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let scrollView = superview as? UIScrollView, (scrollView.isDragging || scrollView.isTracking || scrollView.isDecelerating) {
            return
        } else if let scrollView = superview?.superview as? UIScrollView, (scrollView.isDragging || scrollView.isTracking || scrollView.isDecelerating) {
            return
        } else if let scrollView = superview?.superview?.superview as? UIScrollView, (scrollView.isDragging || scrollView.isTracking || scrollView.isDecelerating) {
            return
        }
        super.touchesBegan(touches, with: event)
    }

    open override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let scrollView = superview as? UIScrollView, (scrollView.isDragging || scrollView.isTracking || scrollView.isDecelerating) {
            return
        } else if let scrollView = superview?.superview as? UIScrollView, (scrollView.isDragging || scrollView.isTracking || scrollView.isDecelerating) {
            return
        } else if let scrollView = superview?.superview?.superview as? UIScrollView, (scrollView.isDragging || scrollView.isTracking || scrollView.isDecelerating) {
            return
        }
        super.touchesMoved(touches, with: event)
    }

    open override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
    }

    open override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesCancelled(touches, with: event)
    }
}

