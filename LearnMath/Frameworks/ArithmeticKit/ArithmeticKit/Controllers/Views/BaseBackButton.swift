//
//  BaseBackButton.swift
//  Alamofire
//
//  Created by Jackie on 9/7/24.
//

import Foundation
import AppearanceKit

public class BaseBackButton: ScaleableButton {
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        
        self.imageView?.frame = CGRect(x: 24.0.scale(), y: (self.bounds.height - 28.0.scale()) * 0.5, width: 28.0.scale(), height: 28.0.scale())
    }
    
}
