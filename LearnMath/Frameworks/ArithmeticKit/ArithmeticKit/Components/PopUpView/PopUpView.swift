//
//  PopUpView.swift
//  ArithmeticKit_Example
//
//  Created by Jackie on 8/2/24.
//  Copyright © 2024 3commas. All rights reserved.
//

import UIKit
import AppearanceKit
import SnapKit
import pop

public class PopUpView: BaseViewController {
    
    public var hideActionCompletion: (() -> Void)?
    
    public var uiConfig: PopUpUIConfig
    
    private lazy var bgButton: UIButton = {
        let btn = UIButton(type: .custom)
        btn.backgroundColor = UIColor.ap.color(ColorSet.black)?.withAlphaComponent(0.6)
        btn.addTarget(self, action: #selector(bgButtonAction), for: .touchUpInside)
        return btn
    }()
    
    private var contentView: PopUpBaseBindView?
    
    public init(uiConfig: PopUpUIConfig, bindView: @escaping () -> PopUpBaseBindView) {
        self.uiConfig = uiConfig
        super.init([:])
        
        self.contentView = bindView()
        self.contentView?.bind(self)
    }
    
    required public init(_ params: [String : Any]) {
        fatalError("init(_:) has not been implemented")
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()

        setupSubViews()
    }

}

// MARK: - Public

public extension PopUpView {
    
    func show(in vc: UIViewController?) {
        let nav = BaseNavigationViewController(rootViewController: self)
        let animator = PresenterAnimator()
        animator.initContentAnimationAction = { [weak self] toView, containerView in
            self?.contentView?.layer.pop_removeAllAnimations()
            self?.contentView?.layer.transform = CATransform3DMakeTranslation(0.0, 0.0, 0.0)
            self?.contentView?.frame = CGRect(x: 0.0, y: self?.uiConfig.contentViewTopY ?? 0.0, width: Appearance.screenW, height: self?.uiConfig.contentViewHeight ?? 0.0)
            self?.contentView?.transform = CGAffineTransform(translationX: 0.0, y: (self?.view.frame.height ?? 0.0) - (self?.uiConfig.contentViewTopY ?? 0.0))
            self?.contentView?.alpha = 1.0
            self?.animationRun(display: true)
            self?.bgButton.alpha = 0.0
        }
        animator.presentContentAnimationAction = { [weak self] toView, containerView in
            self?.bgButton.alpha = 1.0
        }
        animator.dismissContentAnimationAction = { [weak self] fromView, containerView in
            self?.bgButton.alpha = 0.0
        }
        animator.dismissContentCompleteAnimationAction = { [weak self] fromView, containerView in
            self?.contentView?.alpha = 0.0
        }
        nav.animator = animator
        nav.transitioningDelegate = animator
        nav.modalPresentationStyle = .custom
        if let vc = vc {
            vc.present(nav, animated: true)
        }
    }
    
    func hide(completion: (() -> Void)? = nil, shouldCallback: Bool = true) {
        animationRun(display: false)
        self.navigationController?.dismiss(animated: true, completion: { [weak self] in
            if shouldCallback {
                self?.hideActionCompletion?()
            }
            completion?()
        })
    }
    
}

// MARK: - Private

private extension PopUpView {
    
    func setupSubViews() {
        // bgButton
        bgButton.frame = view.bounds
        view.addSubview(bgButton)
        
        // contentView
        if let contentView = self.contentView {
            contentView.frame = CGRect(x: 0.0, y: uiConfig.contentViewTopY, width: Appearance.screenW, height: uiConfig.contentViewHeight)
            contentView.ap.roundCorners(corners: [.topLeft, .topRight], radius: 30.0.scale())
            view.addSubview(contentView)
        }
    }
    
    func animationRun(display: Bool) {
        if display {
            let anim = POPSpringAnimation(propertyNamed: kPOPLayerTranslationY)
            anim?.springBounciness = 6.0
            anim?.springSpeed = 5.0
            anim?.fromValue = self.view.frame.height - uiConfig.contentViewTopY
            anim?.toValue = 0.0
            anim?.removedOnCompletion = true
            anim?.completionBlock = { [weak self] anim, finished in
                if finished {
                    self?.contentView?.layer.pop_removeAnimation(forKey: "spring_start")
                }
            }
            self.contentView?.layer.pop_add(anim, forKey: "spring_start")
        } else {
            let anim = POPSpringAnimation(propertyNamed: kPOPLayerTranslationY)
            anim?.springBounciness = 6.0
            anim?.springSpeed = 5.0
            anim?.fromValue = 0.0
            anim?.toValue = self.view.frame.height - uiConfig.contentViewTopY
            anim?.removedOnCompletion = true
            anim?.completionBlock = { [weak self] anim, finished in
                if finished {
                    self?.contentView?.layer.pop_removeAnimation(forKey: "spring_end")
                }
            }
            self.contentView?.layer.pop_add(anim, forKey: "spring_end")
        }
    }
    
}

// MARK: - Action

private extension PopUpView {
    
    @objc func bgButtonAction() {
        hide()
    }
    
}
