//
//  EmptyContentView.swift
//  AppearanceKit_Example
//
//  Created by 黄杰 on 2021/3/27.
//  Copyright © 2021 3commas. All rights reserved.
//

import UIKit
import SnapKit

public protocol EmptyContentViewDelegate: NSObjectProtocol {
    /// 点击了view
    func emptyContentView(didClickedEmptyContentView emptyContentView: EmptyContentView)
}

public class EmptyContentView: UIView {
    
    public weak var delegate: EmptyContentViewDelegate?
    
    public var topSpacing: CGFloat = 120.0
    
    public var spacingBetIconAndTitle: CGFloat = 10.0
    
    public var spacingBetTitleAndSubtitle: CGFloat = 5.0
    
    public var isShowIcon: Bool = true
    
    public var icon: UIImage? = UIImage(named: "emptyOne", in: Configurations.bundle, compatibleWith: nil)
    
    public var titleNumberOfLine: Int = 0
    
    public var titleAttributes: [NSAttributedString.Key: Any]?
    
    public var titleText: String?
    
    public var titleFont: UIFont? = UIFont.ap.font(ofSize: 15.0)
    
    public var titleTextColor: UIColor? = UIColor(hexString: "#333333", alpha: 0.9)
    
    public var subtitleNumberOfLine: Int = 0
    
    public var subtitleAttributes: [NSAttributedString.Key: Any]?
    
    public var subtitleText: String?
    
    public var subtitleFont: UIFont? = UIFont.ap.font(ofSize: 12.0)
    
    public var subtitleTextColor: UIColor? = UIColor(hexString: "#666666", alpha: 0.9)
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.distribution = .fill
        stackView.axis = .vertical
        stackView.alignment = .center
        return stackView
    }()

    public lazy var iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    public lazy var titleLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    public lazy var subtitleLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func didMoveToSuperview() {
        super.didMoveToSuperview()
        
        if self.superview == nil {
            return
        }
        
        self.stackView.spacing = spacingBetIconAndTitle
        self.addSubview(self.stackView)
        
        self.stackView.snp.makeConstraints { make in
            make.top.equalTo(topSpacing)
            make.leading.equalTo(32.0)
            make.trailing.equalTo(-32.0)
        }
        
        // iconImageView
        self.iconImageView.image = self.icon
        self.stackView.addArrangedSubview(self.iconImageView)
        
        var iconImageW: CGFloat = self.e_width - 20.0
        var iconImageH: CGFloat = iconImageW
        if let icon = self.icon {
            iconImageW = icon.size.width
            iconImageH = icon.size.height
        }
        self.iconImageView.snp.makeConstraints { make in
            make.size.equalTo(CGSize(width: iconImageW, height: iconImageH))
        }
        
        // titleLabel
        if let titleAttributes = self.titleAttributes {
            self.titleLabel.attributedText = NSAttributedString(string: self.titleText ?? "", attributes: titleAttributes)
        } else {
            var attributes: [NSAttributedString.Key: Any] = [:]
            if let font = self.titleFont {
                attributes[.font] = font
            }
            if let textColor = self.titleTextColor {
                attributes[.foregroundColor] = textColor
            }
            let style = NSMutableParagraphStyle()
            style.alignment = .center
            style.lineSpacing = 1.0
            attributes[.paragraphStyle] = style
            self.titleLabel.attributedText = NSAttributedString(string: self.titleText ?? "", attributes: attributes)
        }
        self.titleLabel.numberOfLines = self.titleNumberOfLine
        self.stackView.addArrangedSubview(self.titleLabel)
        
        // subtitleLabel
        if let title = self.subtitleText, !title.isEmpty {
            if let titleAttributes = self.subtitleAttributes {
                self.subtitleLabel.attributedText = NSAttributedString(string: title, attributes: titleAttributes)
            } else {
                var attributes: [NSAttributedString.Key: Any] = [:]
                if let font = self.subtitleFont {
                    attributes[.font] = font
                }
                if let textColor = self.subtitleTextColor {
                    attributes[.foregroundColor] = textColor
                }
                let style = NSMutableParagraphStyle()
                style.alignment = .center
                style.lineSpacing = 1.0
                attributes[.paragraphStyle] = style
                self.subtitleLabel.attributedText = NSAttributedString(string: title, attributes: attributes)
            }
            self.subtitleLabel.numberOfLines = self.subtitleNumberOfLine
            self.addSubview(self.subtitleLabel)
            
            self.subtitleLabel.snp.makeConstraints { make in
                make.leading.trailing.equalTo(self.stackView)
                make.top.equalTo(self.stackView.snp.bottom).offset(self.spacingBetTitleAndSubtitle)
            }
        }
        
        self.iconImageView.isHidden = !isShowIcon
        
        if let title = self.titleText, !title.isEmpty {
            self.titleLabel.isHidden = false
        } else {
            self.titleLabel.isHidden = true
        }
    }
}

// MARK: - Action

private extension EmptyContentView {
    
    @objc func tapEmptyContentViewAction() {
        delegate?.emptyContentView(didClickedEmptyContentView: self)
    }
}
