//
//  RealmActor.swift
//  DbService_Example
//
//  Created by Jackie on 7/21/24.
//  Copyright © 2024 3commas. All rights reserved.
//

import Foundation

class RealmExecutor: NSObject {
    public static let dispatcher: DispatchQueue = DispatchQueue(label: "com.hj.realm.queue", autoreleaseFrequency: .workItem)
}

final class RealmAsyncExecutor: SerialExecutor {

    func enqueue(_ job: UnownedJob) {
        RealmExecutor.dispatcher.async {
            // 执行这个 job
            job.runSynchronously(on: self.asUnownedSerialExecutor())
        }
    }

    func asUnownedSerialExecutor() -> UnownedSerialExecutor {
        UnownedSerialExecutor(ordinary: self)
    }
    
}

final class RealmSyncExecutor: SerialExecutor {

    func enqueue(_ job: UnownedJob) {
        RealmExecutor.dispatcher.sync {
            // 执行这个 job
            job.runSynchronously(on: self.asUnownedSerialExecutor())
        }
    }

    func asUnownedSerialExecutor() -> UnownedSerialExecutor {
        UnownedSerialExecutor(ordinary: self)
    }
    
}

@globalActor actor RealmAsyncActor: GlobalActor {
    
    static var shared: RealmAsyncActor = RealmAsyncActor()
    
    typealias ActorType = RealmAsyncActor
    
    private static let _sharedExecutor = RealmAsyncExecutor()

    static let sharedUnownedExecutor: UnownedSerialExecutor = _sharedExecutor.asUnownedSerialExecutor()

    let unownedExecutor: UnownedSerialExecutor = sharedUnownedExecutor
    
}

@globalActor actor RealmSyncActor: GlobalActor {
    
    static var shared: RealmSyncActor = RealmSyncActor()
    
    typealias ActorType = RealmSyncActor
    
    private static let _sharedExecutor = RealmSyncExecutor()

    static let sharedUnownedExecutor: UnownedSerialExecutor = _sharedExecutor.asUnownedSerialExecutor()

    let unownedExecutor: UnownedSerialExecutor = sharedUnownedExecutor
    
}
