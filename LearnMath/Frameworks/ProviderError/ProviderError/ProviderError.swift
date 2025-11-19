//
//  ProviderError.swift
//  ProviderError_Example
//
//  Created by 3commas on 3/13/21.
//  Copyright © 2021 3commas. All rights reserved.
//

import Foundation

public enum ProviderErrorCode: Int {

    // ================= 用户中心 =================

    case invalidAuthToken = 10001


    case invalidSystemTime = 9983
    case invalidParamsParse = 9901
    case invalidSign = 9902

    /// 封号
    case accountBanned = 10031

    // ================= 客户端自定义的 Error =================

    case cancelLoginError = 440000

    case unknown = 440404
    case jsonSerializationFailed = 440407
    case generationObjectFailed = 440408
    case timedOutCode = -1001
    case notConnectedToInternetCode = -1009

    public var value: Int {
        return self.rawValue
    }

    /// 是否需要重新登录
    public var showReLogin: Bool {
        if self == .invalidAuthToken || self == .accountBanned {
            return true
        }
        return false
    }
}

public struct ProviderError: Swift.Error {

    public let code: ProviderErrorCode
    public let failureReason: String
    public let rawCode: Int
    public let raw: Any?
    public let url: URL?

    public init(code: Int, failureReason: String, url: URL? = nil, raw: Any? = nil) {

        var reason: String = failureReason

        let timedOutCode: Int = -1001
        let notConnectedToInternetCode: Int = -1009

        if code == timedOutCode {
            reason = "ProviderError.request.timeout".localized
        } else if code == notConnectedToInternetCode {
            reason = "ProviderError.network.none".localized
        }

        if code >= 500 && code < 510, let url = url {
            if let module = url.host?.split(separator: ".").first {
                reason += "\n" + String(module)
            }
            let path = url.path
            if !path.isEmpty {
                reason += " " + path
            }
        }

        self.url = url
        self.rawCode = code
        self.raw = raw
        self.code = ProviderErrorCode(rawValue: code) ?? ProviderErrorCode.unknown
        self.failureReason = reason
    }
}

extension ProviderError {

    public static func jsonSerializationFailed(of url: URL?) -> ProviderError {
        return ProviderError(code: ProviderErrorCode.jsonSerializationFailed.rawValue, failureReason: "ProviderError.model.parse.failure".localized, url: url)
    }

    public static func generationObjectFailed(of url: URL?) -> ProviderError {
        return ProviderError(code: ProviderErrorCode.generationObjectFailed.rawValue, failureReason: "ProviderError.model.parse.failure".localized, url: url)
    }

    public static func serverDisconnect(of url: URL?, statusCode: Int) -> ProviderError {
        let msg = "ProviderError.request.disconnect".localized + " \(statusCode)"
        return ProviderError(code: 444409, failureReason: msg, url: url)
    }

    public static func generationFailed(of failureReason: String, url: URL? = nil, file: String = #file, method: String = #function, line: Int = #line) -> ProviderError {

        var dateString: String = ""

        #if DEBUG
        let dateFormatter: DateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm:ss"
        dateString = dateFormatter.string(from: Date())
        #endif

        let reason: String = "💣 \(dateString) \((file as NSString).lastPathComponent)[\(line)], \(method): \(failureReason)"

        return ProviderError(code: ProviderErrorCode.generationObjectFailed.rawValue, failureReason: reason, url: url)
    }
}



