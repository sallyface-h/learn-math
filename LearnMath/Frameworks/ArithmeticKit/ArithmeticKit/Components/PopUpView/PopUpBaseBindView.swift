//
//  PopUpBaseBindView.swift
//  ArithmeticKit
//
//  Created by Jackie on 8/3/24.
//

import UIKit

open class PopUpBaseBindView: UIView & PopUpViewable {
    
    public weak var rootView: PopUpView?
    
    public func bind(_ view: PopUpView) {
        self.rootView = view
    }

}
