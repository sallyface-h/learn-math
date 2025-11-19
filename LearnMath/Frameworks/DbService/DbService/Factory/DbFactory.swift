//
//  DbFactory.swift
//  DbService_Example
//
//  Created by Jackie on 7/21/24.
//  Copyright © 2024 3commas. All rights reserved.
//

import Foundation

enum DbServicePlatform {
    case realm
}

struct DbFactory {
    
    static func createService(_ platform: DbServicePlatform) -> DbServiceable? {
        switch platform {
        case .realm:
            let service = RealmDbService()
            return service
        }
    }
    
}
