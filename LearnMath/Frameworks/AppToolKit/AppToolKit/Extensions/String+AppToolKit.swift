//
//  String+Egg.swift
//  EggKit
//
//  Created by k on 09/11/2016.
//  Copyright © 2016 egg. All rights reserved.
//

import UIKit
import CommonCrypto
import CryptoKit

public extension StringProxy {
    
    static func getUUID() -> String {
        let uuid = UUID().uuidString
        let uuidWithoutHyphens = uuid.replacingOccurrences(of: "-", with: "")
        return uuidWithoutHyphens
    }

    enum TrimmingType {

        /// 首尾空格
        case whitespace

        /// 首尾空格和换行
        case whitespaceAndNewline
    }

    func trimming(_ trimmingType: TrimmingType) -> String {
        switch trimmingType {
        case .whitespace:
            return base.trimmingCharacters(in: CharacterSet.whitespaces)
        case .whitespaceAndNewline:
            return base.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        }
    }

    func replaceLineBlanks() -> String {
        if !base.isEmpty {
            do {
                let pattern = "(\r?\n(\\s*\r?\n)+)"
                let regExp = try NSRegularExpression(pattern: pattern, options: NSRegularExpression.Options.caseInsensitive)
                let replaceStr = regExp.stringByReplacingMatches(in: base, options: .reportProgress, range: NSMakeRange(0, base.utf16.count), withTemplate: "\r\n")
                return replaceStr
            } catch {
                return base
            }
        } else {
            return base
        }
    }

    // 将换行符转成UILabel可以展示的
    func transformEnterKeyToLabel() -> String {
        if !base.isEmpty {
            let relaceText = base.replacingOccurrences(of: "\r\n", with: "\n\n")
            return relaceText
        } else {
            return base
        }
    }

    var md5: String? {

        let digest = Insecure.MD5.hash(data: Data(base.utf8))

        return digest.map {
            String(format: "%02hhx", $0)
        }.joined()
    }

    /// 是否是包含中文
    var isContainsChineseCharacter: Bool {
        for character in base {
            if character.egg.isChineseCharacter {
                return true
            }
        }
        return false
    }

    /// 是否是纯中文字
    var isPrueChinese: Bool {
        for character in base {
            if !character.egg.isChineseCharacter {
                return false
            }
        }
        return true
    }

    /// 判断手机号码
    var isPhoneNumber: Bool {
        do {
            let pattern = "^1[3|4|5|7|8]\\d{9}$"
            let regex = try NSRegularExpression(pattern: pattern, options: .caseInsensitive)
            let res = regex.matches(in: base, options: .reportCompletion, range: NSMakeRange(0, base.count))
            return !res.isEmpty
        } catch {
            return false
        }
    }

    /// 隐藏手机号中间四位
    /// 传入的必须是11位手机号
    var replacePhone: String {
        let start = base.index(base.startIndex, offsetBy: 3)
        let end = base.index(base.startIndex, offsetBy: 7)
        let range = Range(uncheckedBounds: (lower: start, upper: end))
        return base.replacingCharacters(in: range, with: "****")
    }
}

extension StringProxy {

    public func substring(from: Int, to: Int) -> String {

        if (to - from) < 0 {
            return ""
        }

        let start = base.utf16.index(base.startIndex, offsetBy: from)
        let end = base.utf16.index(start, offsetBy: min(to - from, base.utf16.count))
        return String(base[start..<end])
    }

    public func substring(range: NSRange) -> String {
        return substring(from: range.lowerBound, to: range.upperBound)
    }

    public func slice(from start: String, to: String) -> String? {

        if start.isEmpty {
            return (base.range(of: to, range: base.startIndex..<base.endIndex)?.lowerBound).map { eInd in
                String(base[base.startIndex..<eInd])
            }
        }

        return (base.range(of: start)?.upperBound).flatMap { sInd -> String? in
            (base.range(of: to, range: sInd..<base.endIndex)?.lowerBound).map { eInd in
                String(base[sInd..<eInd])
            }
        }
    }

    public func rangeFromNSRange(range: NSRange) -> Range<String.Index>? {
        guard let from = base.utf16.index(base.utf16.startIndex, offsetBy: range.location, limitedBy: base.utf16.endIndex) else { return nil }
        guard let to = base.utf16.index(from, offsetBy: range.length, limitedBy: base.utf16.endIndex) else { return nil }
        return from ..< to
    }
    
    public func nsRange(of substring: String) -> NSRange? {
        guard let range = base.range(of: substring) else {
            return nil
        }
        return NSRange(range, in: base)
    }
    
    public func nsRange(from range: Range<String.Index>) -> NSRange {
        return NSRange(range, in: base)
    }
}

public extension StringProxy {

    func height(width: CGFloat, attributes: [NSAttributedString.Key: Any]) -> CGFloat {
        let rect = base.boundingRect(with: CGSize(width: width, height: CGFloat.greatestFiniteMagnitude), options: [.truncatesLastVisibleLine, .usesLineFragmentOrigin, .usesFontLeading], attributes: attributes, context: nil)
        return rect.height.rounded(.up)
    }

    func width(withFontSize fontSize: CGFloat, weight: UIFont.Weight = .regular) -> CGFloat {
        let rect = base.boundingRect(with: CGSize(width: CGFloat.infinity, height: CGFloat.greatestFiniteMagnitude), options: [.truncatesLastVisibleLine, .usesLineFragmentOrigin, .usesFontLeading], attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: fontSize)], context: nil)
        return rect.width.rounded(.up)
    }
    
    func width(withFont font: UIFont) -> CGFloat {
        let rect = base.boundingRect(with: CGSize(width: CGFloat.infinity, height: CGFloat.greatestFiniteMagnitude), options: [.truncatesLastVisibleLine, .usesLineFragmentOrigin, .usesFontLeading], attributes: [NSAttributedString.Key.font: font], context: nil)
        return rect.width.rounded(.up)
    }
}

public struct StringProxy {

    public let base: String

    init(_ base: String) {
        self.base = base
    }
}

extension String {

    public var egg: StringProxy {
        return StringProxy(self)
    }

    public static var egg: StringProxy.Type {
        return StringProxy.self
    }
}
