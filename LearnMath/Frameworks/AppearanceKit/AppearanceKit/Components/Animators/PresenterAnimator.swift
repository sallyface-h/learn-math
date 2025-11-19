//
//  PCPresenterAnimator.swift
//  EggPresenterKit_Example
//
//  Created by 黄杰 on 2017/12/13.
//  Copyright © 2017年 CocoaPods. All rights reserved.
//

import UIKit

@objc(PresenterAnimator)
@objcMembers
public class PresenterAnimator: BaseAnimator {
 
    override public func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        super.animateTransition(using: transitionContext)

        guard let fromViewController = transitionContext.viewController(forKey: .from), let toViewController = transitionContext.viewController(forKey: .to) else { return }
        
        let containerView = transitionContext.containerView
        
        if !isDismiss { // pop动画
            guard let toView = transitionContext.view(forKey: UITransitionContextViewKey.to) else {
                return
            }
            self.initContentAnimationAction?(toView, containerView)

            containerView.addSubview(toView)
            containerView.bringSubviewToFront(toView)
            
            if toViewController.modalPresentationStyle == .custom {
                fromViewController.beginAppearanceTransition(false, animated: true)
            }

            UIView.animate(withDuration: animationDuration, delay: 0.0, options: [.curveEaseIn], animations: {
                self.presentContentAnimationAction?(toView, containerView)
            }, completion: { _ in
                if toViewController.modalPresentationStyle == .custom {
                    fromViewController.endAppearanceTransition()
                }
                transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
                self.presentContentCompleteAnimationAction?(toView, containerView)
            })
            
        } else { // dismiss动画
            if toViewController.modalPresentationStyle == .custom {
                fromViewController.endAppearanceTransition()
            }
            guard let fromView = transitionContext.view(forKey: .from) else {
                return
            }

            if fromViewController.modalPresentationStyle == .custom {
                toViewController.beginAppearanceTransition(true, animated: true)
            }

            if let toView = transitionContext.view(forKey: .to), isPush {
                containerView.addSubview(toView)
            }

            containerView.bringSubviewToFront(fromView)

            UIView.animate(withDuration: animationDuration, delay: 0.0, options: [.curveEaseOut], animations: {
                self.dismissContentAnimationAction?(fromView, containerView)
            }, completion: { _ in
                if fromViewController.modalPresentationStyle == .custom {
                    toViewController.endAppearanceTransition()
                }
                transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
                self.dismissContentCompleteAnimationAction?(fromView, containerView)
            })
        }
    }
    
}
