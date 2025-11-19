//
//  GlobalMethods.swift
//  Pods
//
//  Created by Limon F. on 3/7/2020.
//

import Foundation
import JustLog

public typealias EmptyBlock = (() -> Void)
public typealias ErrorBlock = ((_ error: Error) -> Void)

var environmentKey: String = "release"

fileprivate enum LogType {
    case debug
    case warning
    case error
    case info
    case network
}

private var logNumber = 0

public func debug_print<T>(_ tag: String, message: T, error: Error? = nil, userInfo: [String: Any]? = nil, _ file: StaticString = #file, _ method: StaticString = #function, _ line: UInt = #line) {
    if environmentKey.lowercased() != "release" {
        egg_print(tag, message: message, .debug, error: error as NSError?, userInfo: userInfo, file, method, line)
    }
}

public func error_print<T>(_ tag: String, message: T, error: Error? = nil, userInfo: [String: Any]? = nil, _ file: StaticString = #file, _ method: StaticString = #function, _ line: UInt = #line) {
    egg_print(tag, message: message, .error, error: error as NSError?, userInfo: userInfo, file, method, line)
}

public func info_print<T>(_ tag: String, message: T, error: Error? = nil, userInfo: [String: Any]? = nil, _ file: StaticString = #file, _ method: StaticString = #function, _ line: UInt = #line) {
    egg_print(tag, message: message, .info, error: error as NSError?, userInfo: userInfo, file, method, line)
}

public func networkLoggerPlugin_print<T>(_ tag: String, message: T, error: Error? = nil, userInfo: [String: Any]? = nil) {
    egg_print(tag, message: message, .network, error: error as NSError?, userInfo: userInfo)
}

fileprivate func egg_print<T>(_ tag: String, message: T, _ type: LogType, error: Error? = nil, userInfo: [String: Any]? = nil, _ file: StaticString = #file, _ method: StaticString = #function, _ line: UInt = #line) {
    switch type {
    case .debug:
        Logger.shared.debug("[\(logNumber)] \(tag) \(message)", error: error as NSError?, userInfo: userInfo, file, method, line)
    case .warning:
        Logger.shared.warning("[\(logNumber)] \(tag) \(message)", error: error as NSError?, userInfo: userInfo, file, method, line)
    case .error:
        Logger.shared.error("[\(logNumber)] \(tag) \(message)", error: error as NSError?, userInfo: userInfo, file, method, line)
    case .info:
        Logger.shared.info("[\(logNumber)] \(tag) \(message)", error: error as NSError?, userInfo: userInfo, file, method, line)
    case .network:
        Logger.shared.verbose("[\(logNumber)] \(tag) \(message)", error: error as NSError?, userInfo: userInfo)
    }

    logNumber += 1
}

public func delay(_ seconds: Double, delayedCode: @escaping ()->()) {
    let targetTime = DispatchTime.now() + Double(Int64(Double(NSEC_PER_SEC) * seconds)) / Double(NSEC_PER_SEC)
    DispatchQueue.main.asyncAfter(deadline: targetTime) {
        delayedCode()
    }
}

func setupLogger() {

    let logger = Logger.shared

    // custom keys
    logger.logTypeKey = "logtype"
    logger.appVersionKey = "app_version"
    logger.iosVersionKey = "ios_version"
    logger.deviceTypeKey = "ios_device"

    // file destination
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy-MM-dd"
    let date = formatter.string(from: Date())
    logger.logFilename = "\(date).log"

    // logstash destination
    logger.enableLogstashLogging = false
//    logger.logstashHost = "listener.logz.io"
//    logger.logstashPort = 5052
//    logger.logstashTimeout = 5
//    logger.logLogstashSocketActivity = true

    // logz.io support
    //logger.logzioToken = <logzioToken>

    // untrusted (self-signed) logstash server support
    //logger.allowUntrustedServer = <Bool>

    // default info
    logger.defaultUserInfo = ["application": Bundle.main.bundleIdentifier ?? "Bundle.main.bundleIdentifier",
                              "environment": environmentKey,
                              "session": UUID().uuidString]
    logger.setup()
    logger.console.format = "$Dyyyy-MM-dd HH:mm:ss.SSS$d $C$L$c $N.$F:$l - $M"
    logger.file.format = logger.console.format

    debug_print("Logger", message: Logger.shared.baseUrlForFileLogging?.absoluteString ?? "")
}
