//
//  Collection+Egg.swift
//  EggKit
//
//  Created by k on 09/11/2016.
//  Copyright © 2016 egg. All rights reserved.
//

import Foundation

public struct SafeCollection<Base: Collection> {

    private var _base: Base
    public init(_ base: Base) {
        _base = base
    }

    public typealias Index = Base.Index
    public var startIndex: Index {
        return _base.startIndex
    }

    public var endIndex: Index {
        return _base.endIndex
    }

    public subscript(index: Base.Index) -> Base.Iterator.Element? {
        if _base.distance(from: startIndex, to: index) >= 0 && _base.distance(from: index, to: endIndex) > 0 {
            return _base[index]
        }
        return nil
    }

    public subscript(bounds: Range<Base.Index>) -> Base.SubSequence? {
        if _base.distance(from: startIndex, to: bounds.lowerBound) >= 0 && _base.distance(from: bounds.upperBound, to: endIndex) >= 0 {
            return _base[bounds]
        }
        return nil
    }

    var safe: SafeCollection<Base> { //Allows to chain ".safe" without side effects
        return self
    }
}

public extension Collection {
    var safe: SafeCollection<Self> {
        return SafeCollection(self)
    }
}

public extension Sequence where Self.Iterator.Element: Equatable {

    /// if elements hadn't be sorted, the result maybe not unique
    func grouped() -> [[Iterator.Element]] {
        return _grouped(by: ==)
    }
}

public extension Sequence {

    // must be sorted first
    fileprivate func _grouped(by predicate: (Self.Iterator.Element, Self.Iterator.Element) -> Bool) -> [[Self.Iterator.Element]] {
        var results = [Array<Iterator.Element>]()

        forEach {
            if var lastGroup = results.last, let element = lastGroup.last, predicate(element, $0) {
                lastGroup.append($0)
                results.removeLast()
                results.append(lastGroup)
            } else {
                results.append([$0])
            }
        }
        return results
    }

}

public extension Sequence where Self.Iterator.Element: Comparable {

    func grouped(by predicate: (Self.Iterator.Element, Self.Iterator.Element) -> Bool) -> [[Self.Iterator.Element]] {
        return sorted(by: predicate)._grouped(by: predicate)
    }
}

public extension Sequence {

    func grouped<G: Hashable>(by closure: (Iterator.Element) -> G) -> [G: [Iterator.Element]] {
        var results = [G: Array<Iterator.Element>]()

        forEach {
            let key = closure($0)

            if var array = results[key] {
                array.append($0)
                results[key] = array
            }
            else {
                results[key] = [$0]
            }
        }

        return results
    }
}
