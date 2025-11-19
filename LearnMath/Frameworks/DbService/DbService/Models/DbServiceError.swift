//
//  DbServiceError.swift
//  DbService_Example
//
//  Created by Jackie on 7/21/24.
//  Copyright © 2024 3commas. All rights reserved.
//

import Foundation

public enum DbServiceError: Error {
    /// 服务不存在
    case serviceNotExist
    /// db目录不正确
    case dbPathNotCorrect
    /// 参数错误
    case paramsError
    /// realm不存在
    case realmNotExist
    /// realm抛出的错误信息
    case realmError(_ error: Error)
}
