//
//  WebViewLeakAvoider.swift
//  THG
//
//  Created by 黄杰 on 2017/8/24.
//  Copyright © 2017年 zwx. All rights reserved.
//

import UIKit
import WebKit

class WebViewLeakAvoider: NSObject, WKScriptMessageHandler {
    
    weak var delegate : WKScriptMessageHandler?
    init(delegate:WKScriptMessageHandler) {
        self.delegate = delegate
        super.init()
    }
    func userContentController(_ userContentController: WKUserContentController,
                               didReceive message: WKScriptMessage) {
        self.delegate?.userContentController(
            userContentController, didReceive: message)
    }
}
