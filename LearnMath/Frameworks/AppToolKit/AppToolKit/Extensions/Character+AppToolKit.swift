//
//  Character+Egg.swift
//  EggKit_Example
//
//  Created by Limon F. on 23/3/2018.
//  Copyright © 2018年 CocoaPods. All rights reserved.
//

import UIKit

extension CharacterProxy {

    public var isChineseCharacter: Bool {
        if ("\u{4E00}" <= base  && base <= "\u{9FA5}") {
            return true
        }
        return false
    }
}

public struct CharacterProxy {

    public let base: Character

    init(_ base: Character) {
        self.base = base
    }
}

extension Character {

    public var egg: CharacterProxy {
        return CharacterProxy(self)
    }

    public static var egg: CharacterProxy.Type {
        return CharacterProxy.self
    }
}
