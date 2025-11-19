//
//  Listenable.swift
//  EmperorKit_Example
//
//  Created by 3commas on 2/24/21.
//  Copyright © 2021 3commas. All rights reserved.
//

import Foundation

public struct Listener<T>: Hashable {

    let name: String

    public typealias Action = (T) -> Void
    let action: Action

    public var hashValue: Int {
        return name.hashValue
    }

    public func hash(into hasher: inout Hasher) {
        hasher.combine(name.hashValue)
    }
}

public func ==<T>(lhs: Listener<T>, rhs: Listener<T>) -> Bool {
    return lhs.name == rhs.name
}

public class Listenable<U> {

    public typealias SetterAction = (U) -> Void

    public var value: U {
        didSet {
            setterAction(value)

            for listener in listenerSet {
                listener.action(value)
            }
        }
    }

    private var setterAction: (U) -> Void

    private var listenerSet: Set<Listener<U>> = []

    public func bindListener(with name: String, action: @escaping Listener<U>.Action) {
        let listener = Listener(name: name, action: action)
        listenerSet.update(with: listener)
    }

    public func bindAndFireListener(with name: String, action: @escaping Listener<U>.Action) {
        bindListener(with: name, action: action)

        action(value)
    }

    public func removeListener(with name: String) {
        for listener in listenerSet {
            if listener.name == name {
                listenerSet.remove(listener)
                break
            }
        }
    }

    public func removeAllListeners() {
        listenerSet.removeAll(keepingCapacity: false)
    }

    public init(_ v: U, setterAction action: @escaping SetterAction) {
        value = v
        setterAction = action
    }
}

