//
//  BaseAnimator.swift
//  EggPresenterKit_Example
//
//  Created by 黄杰 on 2017/12/13.
//  Copyright © 2017年 CocoaPods. All rights reserved.
//

import UIKit

@objc(BaseAnimator)
@objcMembers
open class BaseAnimator: UIPercentDrivenInteractiveTransition {

    public var isPush: Bool = false
    
    public var deinitAction: (() -> Void)?

    public var initContentAnimationAction: ((_ toView: UIView, _ containerView: UIView) -> Void)?
    public var presentContentAnimationAction: ((_ toView: UIView, _ containerView: UIView) -> Void)?
    public var presentContentCompleteAnimationAction: ((_ toView: UIView, _ containerView: UIView) -> Void)?
    public var dismissContentAnimationAction: ((_ fromView: UIView, _ containerView: UIView) -> Void)?
    public var dismissContentCompleteAnimationAction: ((_ fromView: UIView, _ containerView: UIView) -> Void)?
    public var isDismiss: Bool = false
    public var animationDuration: TimeInterval = 0.25

    open weak var toVC: UIViewController?
    
    deinit {
        deinitAction?()
    }
    
}

// MARK: - UIViewControllerAnimatedTransitioning

extension BaseAnimator: UIViewControllerAnimatedTransitioning {
    
    public func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return animationDuration
    }
    
    open func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        guard let toViewController = transitionContext.viewController(forKey: .to) else { return }
        
        if !isDismiss && !isPush { // present
            toViewController.view.backgroundColor = UIColor.clear
            toViewController.view.frame = Appearance.screenBounds
            toViewController.view.layer.position = CGPoint(x: Appearance.screenBounds.size.width * 0.5, y: Appearance.screenBounds.size.height * 0.5)
            toViewController.view.layer.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        }
    }
    
}

// MARK: - UIViewControllerTransitioningDelegate

extension BaseAnimator: UIViewControllerTransitioningDelegate {
    
    public func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        isDismiss = false
        isPush = false
        return self
    }
    
    public func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        isDismiss = true
        isPush = false
        return self
    }
    
}

extension BaseAnimator: UINavigationControllerDelegate {

    public func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationController.Operation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        isDismiss = operation == .pop
        isPush = true
        return self
    }
    
}

