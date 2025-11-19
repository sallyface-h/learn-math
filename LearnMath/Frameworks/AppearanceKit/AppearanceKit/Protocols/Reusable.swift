//
//  Reusable.swift
//  Hi.story
//
//  Created by bl4ckra1sond3tre on 1/27/16.
//  Copyright © 2016 bl4ckra1sond3tre. All rights reserved.
//

import UIKit

public protocol Reusable: NSObjectProtocol {
    static var reuseIdentifier: String { get }
}

public protocol NibReusable: Reusable {
    static var nib: UINib { get }
}

public extension Reusable {
    static var reuseIdentifier: String {
        return String(describing: Self.self)
    }
}

public extension NibReusable {
    static var nib: UINib {
        let bundle: Bundle
        let classBundle = Bundle(for: Self.self)
        let module = NSStringFromClass(Self.self).components(separatedBy: ".").first ?? ""
        if let bundleURL = classBundle.url(forResource: module, withExtension: "bundle") {
            bundle = Bundle(url: bundleURL) ?? classBundle
        } else {
            bundle = classBundle
        }
        return UINib(nibName: String(describing: Self.self), bundle: bundle)
    }
}

public enum UICollectionSupplementaryElementKind {
    case header
    case footer

    public var value: String {
        switch self {
        case .header: return UICollectionView.elementKindSectionHeader
        case .footer: return UICollectionView.elementKindSectionFooter
        }
    }
}

// MARK: - UICollectionView

public extension AppearanceX where Base: UICollectionView {

    func register<T: UICollectionViewCell>(reusableCell cellType: T.Type) where T: Reusable {
        base.register(T.self, forCellWithReuseIdentifier: T.reuseIdentifier)
    }

    func register<T: UICollectionViewCell>(reusableCell cellType: T.Type) where T: NibReusable {
        base.register(T.nib, forCellWithReuseIdentifier: T.reuseIdentifier)
    }

    func dequeueReusableCell<T: UICollectionViewCell>(for indexPath: IndexPath) -> T where T: Reusable {
        guard let cell = base.dequeueReusableCell(withReuseIdentifier: T.reuseIdentifier, for: indexPath) as? T else {
            fatalError("Could not dequeue reusable cell with identifier: \(T.reuseIdentifier)")
        }
        return cell
    }

    func registerReusableSupplementaryView<T: UICollectionReusableView>(ofKind elementKind: UICollectionSupplementaryElementKind, viewType: T.Type) where T: NibReusable {
        base.register(T.nib, forSupplementaryViewOfKind: elementKind.value, withReuseIdentifier: T.reuseIdentifier)
    }

    func registerReusableSupplementaryView<T: UICollectionReusableView>(ofKind elementKind: UICollectionSupplementaryElementKind, viewType: T.Type) where T: Reusable {
        base.register(T.self, forSupplementaryViewOfKind: elementKind.value, withReuseIdentifier: T.reuseIdentifier)
    }

    func dequeueReusableSupplementaryView<T: UICollectionReusableView>(ofKind elementKind: UICollectionSupplementaryElementKind, for indexPath: IndexPath) -> T where T: Reusable {
        guard let view = base.dequeueReusableSupplementaryView(ofKind: elementKind.value, withReuseIdentifier: T.reuseIdentifier, for: indexPath) as? T else {
            fatalError("Could not dequeue reusable supplementary view with identifier: \(T.reuseIdentifier)")
        }
        return view
    }

    func dequeueReusableSupplementaryView<T: UICollectionReusableView>(ofKind elementKind: String, for indexPath: IndexPath) -> T where T: Reusable {
        guard let view = base.dequeueReusableSupplementaryView(ofKind: elementKind, withReuseIdentifier: T.reuseIdentifier, for: indexPath) as? T else {
            fatalError("Could not dequeue reusable supplementary view with identifier: \(T.reuseIdentifier)")
        }
        return view
    }
}

// MARK: - UITableView

public extension AppearanceX where Base: UITableView {

    func register<T: UITableViewCell>(reusableCell cellType: T.Type) where T: Reusable {
        base.register(T.self, forCellReuseIdentifier: T.reuseIdentifier)
    }

    func register<T: UITableViewCell>(reusableCell cellType: T.Type) where T: NibReusable {
        base.register(T.nib, forCellReuseIdentifier: T.reuseIdentifier)
    }

    func dequeueReusableCell<T: UITableViewCell>(for indexPath: IndexPath) -> T where T: Reusable {
        guard let cell = base.dequeueReusableCell(withIdentifier: T.reuseIdentifier, for: indexPath) as? T else {
            fatalError("Could not dequeue reusable cell with identifier: \(T.reuseIdentifier)")
        }
        return cell
    }

    func dequeueReusableCell<T: UITableViewCell>() -> T where T: Reusable {
        guard let cell = base.dequeueReusableCell(withIdentifier: T.reuseIdentifier) as? T else {
            fatalError("Could not dequeue reusable cell with identifier: \(T.reuseIdentifier)")
        }
        return cell
    }

    func registerHeaderFooter<T: UITableViewHeaderFooterView>(_ viewType: T.Type) where T: Reusable {

        base.register(T.self, forHeaderFooterViewReuseIdentifier: T.reuseIdentifier)
    }
    
    func registerHeaderFooter<T: UITableViewHeaderFooterView>(_ viewType: T.Type) where T: NibReusable {
        
        base.register(T.nib, forHeaderFooterViewReuseIdentifier: T.reuseIdentifier)
    }

    func dequeueReusableHeaderFooter<T: UITableViewHeaderFooterView>() -> T where T: Reusable {

        guard let view = base.dequeueReusableHeaderFooterView(withIdentifier: T.reuseIdentifier) as? T else {
            fatalError("Could not dequeue headerfooter view with identifier: \(T.reuseIdentifier)")
        }

        return view
    }
}
