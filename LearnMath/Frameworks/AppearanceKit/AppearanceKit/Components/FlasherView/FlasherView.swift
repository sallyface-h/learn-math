//
//  FlasherView.swift
//  EggHUD_Example
//
//  Created by 黄杰 on 2018/11/29.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import UIKit

public enum FlasherStyle {
    case cycleLayer(text: String)
    case label(text: String, title: String?)
    case loading(text: String?)
}

public enum FlasherDirection {
    case top
    case center
}

public class FlasherViewHUD: NSObject {

    public static let shared: FlasherViewHUD = FlasherViewHUD()

    private var flasherView: FlasherView?

    public static func flash(style: FlasherStyle, direction: FlasherDirection = .top, toView: UIView? = nil, delay: TimeInterval = 1.6, animationDuration: TimeInterval = 0.25, backgroundColor: UIColor? = nil) {
        FlasherViewHUD.shared.hide(isAnimation: false)
        FlasherViewHUD.shared.flash(style: style, direction: direction, toView: toView, delay: delay, animationDuration: animationDuration, backgroundColor: backgroundColor)
    }

    public static func show(style: FlasherStyle, direction: FlasherDirection = .top, toView: UIView? = nil, animationDuration: TimeInterval = 0.25, backgroundColor: UIColor? = nil) {
        FlasherViewHUD.shared.hide(isAnimation: false)
        FlasherViewHUD.shared.show(style: style, direction: direction, toView: toView, animationDuration: animationDuration, backgroundColor: backgroundColor)
    }

    public static func hide() {
        FlasherViewHUD.shared.hide()
    }

    private func flash(style: FlasherStyle, direction: FlasherDirection = .top, toView: UIView?, delay: TimeInterval = 1.6, animationDuration: TimeInterval = 0.25, backgroundColor: UIColor? = nil) {
        FlasherView.flash(style: style, direction: direction, toView: toView, delay: delay, animationDuration: animationDuration, backgroundColor: backgroundColor)
    }

    private func show(style: FlasherStyle, direction: FlasherDirection = .top, toView: UIView?, animationDuration: TimeInterval = 0.25, backgroundColor: UIColor? = nil) {
        let toView = FlasherView(style: style, direction: direction, toView: toView, delay: 0.0, backgroundColor: backgroundColor)
        toView.alpha = 0.0
        FlasherViewHUD.shared.flasherView = toView
        UIView.animate(withDuration: animationDuration, delay: 0.0, options: .curveEaseInOut, animations: { [weak toView] in
            toView?.alpha = 1.0
        }, completion: nil)
    }

    private func hide(isAnimation: Bool = true, duration: TimeInterval = 0.1) {
        if isAnimation {
            UIView.animate(withDuration: duration, delay: 0.0, options: .curveEaseOut, animations: {
                FlasherViewHUD.shared.flasherView?.alpha = 0.0
            }, completion: { _ in
                FlasherViewHUD.shared.flasherView?.removeFromSuperview()
                FlasherViewHUD.shared.flasherView = nil
            })
        } else {
            FlasherViewHUD.shared.flasherView?.removeFromSuperview()
            FlasherViewHUD.shared.flasherView = nil
        }
    }
}

public class FlasherView: UIView {

    private let flasherStyle: FlasherStyle
    private let flasherDirection: FlasherDirection
    private var toView: UIView?
    private let delay: TimeInterval

    private lazy var toastButton: UIButton = UIButton(type: .custom)

    private lazy var contentView: UIView = UIView()
    private lazy var verticalStackView: UIStackView = UIStackView()
    private lazy var titleLabel: UILabel = UILabel()
    private lazy var contentLabel: UILabel = UILabel()

    private lazy var horizontalStackView: UIStackView = UIStackView()
    private lazy var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView(style: .medium)

    public init(style: FlasherStyle, direction: FlasherDirection = .top, toView: UIView?, delay: TimeInterval = 0.2, backgroundColor: UIColor? = nil) {
        self.toView = toView
        self.flasherStyle = style
        self.delay = delay
        self.flasherDirection = direction
        super.init(frame: .zero)
        setupSubviews(backgroundColor: backgroundColor)
    }

    public static func flash(style: FlasherStyle, direction: FlasherDirection = .top, toView: UIView?, delay: TimeInterval = 1.6, animationDuration: TimeInterval = 0.25, backgroundColor: UIColor? = nil) {
        let toView = FlasherView(style: style, direction: direction, toView: toView, delay: delay, backgroundColor: backgroundColor)
        toView.alpha = 0.0
        UIView.animate(withDuration: animationDuration, delay: 0.0, options: .curveEaseInOut, animations: { [weak toView] in
            toView?.alpha = 1.0
        }, completion: { [weak toView] _ in
            UIView.animate(withDuration: animationDuration, delay: delay, options: .curveEaseOut, animations: { [weak toView] in
                toView?.alpha = 0.0
            }, completion: { [weak toView] _ in
                toView?.removeFromSuperview()
            })
        })
    }

    private func hide() {
        UIView.animate(withDuration: 0.1, delay: 0.0, options: .curveEaseOut, animations: { [weak self] in
            self?.alpha = 0.0
        }, completion: { [weak self] _ in
            self?.removeFromSuperview()
        })
    }

    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension FlasherView {

    private func setupSubviews(backgroundColor: UIColor? = nil) {
        self.translatesAutoresizingMaskIntoConstraints = false

        switch flasherStyle {
        case let .cycleLayer(text):
            toastButton.translatesAutoresizingMaskIntoConstraints = false
            toastButton.isUserInteractionEnabled = false
            toastButton.setTitle(text, for: .normal)
            toastButton.setTitleColor(UIColor.white, for: .normal)
            toastButton.titleLabel?.font = UIFont.hud_font(ofSize: 14.0, weight: .medium)
            toastButton.backgroundColor = backgroundColor ?? UIColor.black.withAlphaComponent(0.5)
            toastButton.layer.cornerRadius = 18.0
            toastButton.layer.borderColor = UIColor.black.cgColor
            toastButton.layer.borderWidth = 1.0
            toastButton.layer.masksToBounds = true
            toastButton.contentEdgeInsets = UIEdgeInsets(top: 0.0, left: 15.0, bottom: 0.0, right: 15.0)
            addSubview(toastButton)

            toastButton.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
            toastButton.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
            toastButton.topAnchor.constraint(equalTo: topAnchor).isActive = true
            toastButton.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        default:
            // contentView
            contentView.backgroundColor = backgroundColor ?? UIColor.black.withAlphaComponent(0.7)
            contentView.layer.cornerRadius = 14.0
            contentView.layer.masksToBounds = true
            contentView.translatesAutoresizingMaskIntoConstraints = false
            addSubview(contentView)

            let offsetY: CGFloat = flasherDirection == .center ? 0.0 : -32.5
            let contentViewWidth = contentView.widthAnchor.constraint(equalToConstant: 257.0)
            contentView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
            contentView.centerYAnchor.constraint(equalTo: centerYAnchor, constant: offsetY).isActive = true
            NSLayoutConstraint.activate([contentViewWidth])

            // verticalStackView
            verticalStackView.axis = .vertical
            verticalStackView.alignment = .fill
            verticalStackView.distribution = .fill
            verticalStackView.spacing = 10.0
            verticalStackView.translatesAutoresizingMaskIntoConstraints = false
            contentView.addSubview(verticalStackView)

            let verticalStackViewLeading = verticalStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24.0)
            let verticalStackViewTrailing = verticalStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24.0)
            let verticalStackViewTop = verticalStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20.0)
            let verticalStackViewBottom = verticalStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20.0)
            NSLayoutConstraint.activate([verticalStackViewLeading, verticalStackViewTrailing, verticalStackViewTop, verticalStackViewBottom])

            switch flasherStyle {
            case let .label(text, title):
                if let title = title {
                    // titleLabel
                    titleLabel.textAlignment = .center
                    titleLabel.textColor = UIColor.white
                    titleLabel.text = title
                    titleLabel.font = UIFont.hud_font(ofSize: 18.0, weight: .medium)
                    titleLabel.translatesAutoresizingMaskIntoConstraints = false
                    verticalStackView.addArrangedSubview(titleLabel)
                }
                // contentLabel
                contentLabel.textAlignment = .center
                contentLabel.textColor = UIColor.white
                contentLabel.text = text
                contentLabel.font = UIFont.hud_font(ofSize: 14.0)
                contentLabel.numberOfLines = 0
                contentLabel.translatesAutoresizingMaskIntoConstraints = false
                verticalStackView.addArrangedSubview(contentLabel)
            case let .loading(text):
                // horizontalStackView
                horizontalStackView.axis = .horizontal
                horizontalStackView.alignment = text == nil ? .fill : .center
                horizontalStackView.distribution = .fill
                horizontalStackView.spacing = 10.0
                horizontalStackView.translatesAutoresizingMaskIntoConstraints = false
                verticalStackView.addArrangedSubview(horizontalStackView)

                // activityIndicator
                activityIndicator.startAnimating()
                activityIndicator.translatesAutoresizingMaskIntoConstraints = false
                horizontalStackView.addArrangedSubview(activityIndicator)

                activityIndicator.widthAnchor.constraint(equalToConstant: 20.0).isActive = true
                activityIndicator.heightAnchor.constraint(equalToConstant: 20.0).isActive = true

                // contentLabel
                if let text = text {
                    contentLabel.textAlignment = .center
                    contentLabel.textColor = UIColor.white
                    contentLabel.text = text
                    contentLabel.font = UIFont.hud_font(ofSize: 14.0)
                    contentLabel.numberOfLines = 0
                    contentLabel.translatesAutoresizingMaskIntoConstraints = false
                    horizontalStackView.addArrangedSubview(contentLabel)
                } else {
                    NSLayoutConstraint.deactivate([contentViewWidth])
                }
            case .cycleLayer:
                break
            }
        }

        let offsetY: CGFloat = flasherDirection == .center ? 0.0 : -31.5
        if let toView = self.toView {
            let filter = toView.subviews.filter { $0 is FlasherView }
            filter.forEach {
                ($0 as? FlasherView)?.hide()
            }
            toView.addSubview(self)
            self.centerXAnchor.constraint(equalTo: toView.centerXAnchor).isActive = true
            self.centerYAnchor.constraint(equalTo: toView.centerYAnchor, constant: offsetY).isActive = true
            self.heightAnchor.constraint(equalToConstant: 36.0).isActive = true
        } else if let window = UIWindow.key {
            let filter = window.subviews.filter { $0 is FlasherView }
            filter.forEach {
                ($0 as? FlasherView)?.hide()
            }
            window.addSubview(self)
            self.centerXAnchor.constraint(equalTo: window.centerXAnchor).isActive = true
            self.centerYAnchor.constraint(equalTo: window.centerYAnchor, constant: offsetY).isActive = true
            self.heightAnchor.constraint(equalToConstant: 36.0).isActive = true
        }
    }
}

private extension CGFloat {

    var hud_plusScaled: CGFloat {
        let isPlus: Bool = Appearance.screenBounds.width == 414.0
        return isPlus ? hud_scaled : self
    }

    var hud_scaled: CGFloat {
        func getVersionCode() -> String {
            var systemInfo = utsname()
            uname(&systemInfo)
            let versionCode: String = String(validatingUTF8: NSString(bytes: &systemInfo.machine, length: Int(_SYS_NAMELEN), encoding: String.Encoding.ascii.rawValue)!.utf8String!)!
            return versionCode
        }
        let isiPad: Bool = getVersionCode().contains("iPad")
        return isiPad ? self : (self * Appearance.screenBounds.size.width) / 375.0
    }
}

private extension UIFont {

    static func hud_convertPxFontSizeToPtFontSize(_ pxFontSize: CGFloat) -> CGFloat {
        return pxFontSize.hud_plusScaled
    }

    static func hud_font(ofSize pxFontSize: CGFloat, weight: UIFont.Weight = .regular) -> UIFont {
        let ptFontSize = hud_convertPxFontSizeToPtFontSize(pxFontSize)
        return UIFont.systemFont(ofSize: ptFontSize, weight: weight)
    }
}
