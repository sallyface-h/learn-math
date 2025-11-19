//
//  ViewController.swift
//  DbService
//
//  Created by Arithmetic on 07/21/2024.
//  Copyright (c) 2024 Arithmetic. All rights reserved.
//

import UIKit
import RealmSwift

class ViewController: UIViewController {

    func test<T>(f: T) {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("开始")
        
        let migration: MigrationBlock = { migration, oldSchemaVersion in
            
        }
        
        DbService.shared.bindMigration("Test", schemaVersion: 10, migrationBlock: migration, complection: { result in
            
        })
        
        print("过程1")
        
        Task {
            do {
                let dog1 = Dog()
                dog1.age = 10
                dog1.name = "小黄"
                
                let dog2 = Dog()
                dog2.age = 12
                dog2.name = "小红"
                
                let hj = Person()
                hj.name = "黄杰"
                let list = List<Dog>()
                list.append(dog1)
                list.append(dog2)
                hj.dogs = list
                
                try await DbService.shared.create([hj])
            } catch {
                print(error)
            }
        }
        
//        print("过程2")
//        
//        Task { @MainActor in
//            do {
//                try await DbService.shared.update([])
//            } catch {
//                print(error)
//            }
//        }
//        
//        print("过程3")
//        
//        Task { @MainActor in
//            do {
//                let obj = try await DbService.shared.fetchObj(Person.self, forPrimaryKey: "669e0eeca864073eae8e2759")
//                print(obj?.name)
//            } catch {
//                print(error)
//            }
//        }
//        
//        print("过程4")
//        
//        Task { @MainActor in
//            do {
//                let objs: Results<Person>? = try await DbService.shared.fetchList(Person.self)
//                print(objs)
//            } catch {
//                print(error)
//            }
//        }
        
//        print("过程5")
//        
//        Task { @MainActor in
//            do {
//                if let person = try await DbService.shared.fetchObj(Person.self, forPrimaryKey: "669e0eeca864073eae8e2759") {
//                    try await DbService.shared.delete([PersonWrapper(person)])
//                }
//            } catch {
//                print(error)
//            }
//        }
        
        print("过程5")
        
        Task {
            do {
                try await DbService.shared.transactions { (db: Realm) in
                    let person = db.objects(Person.self)
                    db.delete(person)
                }
            } catch {
                print(error)
            }
        }
        
//        let tasks = [task1, task2, task4, task5]
        
        print("结束")
    }
    
}

