//
//  ControllerParameterable.swift
//  ArithmeticKit_Example
//
//  Created by Jackie on 7/28/24.
//  Copyright © 2024 3commas. All rights reserved.
//

import Foundation

public protocol ControllerParameterable: UIViewController {
    
    var params: [String: Any] { get }
    
    init(_ params: [String: Any])
}
