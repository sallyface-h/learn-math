//
//  DirectionView.swift
//  EmperorKit_Example
//
//  Created by 黄杰 on 2021/3/29.
//  Copyright © 2021 3commas. All rights reserved.
//

import UIKit
import AppearanceKit

public enum ImageDirection {
    case top
    case left
    case right
    case bottom
    
    public var isVertical: Bool {
        switch self {
        case .bottom, .top:
            return true
        default:
            return false
        }
    }
}

open class DirectionView: ScaleableButton {
    
    public var image: UIImage? {
        didSet {
            if let image = image {
                self.iconImageView.image = image
                self.setIconImageViewHidden(false)
            } else {
                self.iconImageView.image = nil
                self.setIconImageViewHidden(true)
            }
        }
    }
    
    public var text: String? {
        didSet {
            if let text = text, !text.isEmpty {
                self.nameLabel.text = text
                self.setNameLabelHidden(false)
            } else {
                self.nameLabel.text = nil
                self.setNameLabelHidden(true)
            }
        }
    }
    
    public var font: UIFont? {
        didSet {
            self.nameLabel.font = font
        }
    }
    
    public var textColor: UIColor? {
        didSet {
            self.nameLabel.textColor = textColor
        }
    }
    
    public var textAlignment: NSTextAlignment = .center {
        didSet {
            self.nameLabel.textAlignment = textAlignment
        }
    }
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.distribution = .fill
        stackView.axis = imageDirection.isVertical ? .vertical : .horizontal
        stackView.alignment = .center
        stackView.spacing = spacing
        return stackView
    }()
    
    public lazy var iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = imageContentMode
        return imageView
    }()
    
    public lazy var nameLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    private let imageDirection: ImageDirection
    private let left: CGFloat
    private let right: CGFloat
    private let spacing: CGFloat
    private let imageSize: CGSize?
    private let imageContentMode: UIView.ContentMode

    public init(imageDirection: ImageDirection, left: CGFloat = 0.0, right: CGFloat = 0.0, spacing: CGFloat, imageSize: CGSize? = nil, imageContentMode: UIView.ContentMode = .scaleAspectFit) {
        self.imageDirection = imageDirection
        self.left = left
        self.right = right
        self.spacing = spacing
        self.imageSize = imageSize
        self.imageContentMode = imageContentMode
        super.init(frame: .zero)
        
        self.setupUI()
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension DirectionView {
 
    public func setIconImageViewHidden(_ isHidden: Bool) {
        self.iconImageView.isHidden = isHidden
    }
    
    public func setNameLabelHidden(_ isHidden: Bool) {
        self.nameLabel.isHidden = isHidden
    }
}

// MARK: - Private

private extension DirectionView {
    
    func setupUI() {
        self.stackView.isUserInteractionEnabled = false
        self.stackView.translatesAutoresizingMaskIntoConstraints = false
        self.iconImageView.translatesAutoresizingMaskIntoConstraints = false
        self.nameLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(self.stackView)
        switch self.imageDirection {
        case .top, .left:
            let isTop = self.imageDirection == .top
            self.iconImageView.setContentCompressionResistancePriority(.init(760.0), for: isTop ? .vertical : .horizontal)
            self.nameLabel.setContentHuggingPriority(.init(240.0), for: isTop ? .vertical : .horizontal)
            self.stackView.addArrangedSubview(self.iconImageView)
            self.stackView.addArrangedSubview(self.nameLabel)
        case .bottom, .right:
            let isBottom = self.imageDirection == .bottom
            self.iconImageView.setContentCompressionResistancePriority(.init(760.0), for: isBottom ? .vertical : .horizontal)
            self.nameLabel.setContentHuggingPriority(.init(240.0), for: isBottom ? .vertical : .horizontal)
            self.stackView.addArrangedSubview(self.nameLabel)
            self.stackView.addArrangedSubview(self.iconImageView)
        }
        
        self.stackView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.leading.equalTo(self.left)
            make.trailing.equalTo(-self.right)
        }
        
        if let size = self.imageSize {
            self.iconImageView.snp.makeConstraints { make in
                make.size.equalTo(size)
            }
        }
    }
}
