//
//  RefreshAutoFooter.swift
//  ArithmeticKit
//
//  Created by Jackie on 8/18/24.
//

import UIKit
import MJRefresh

public class RefreshAutoFooter: MJRefreshAutoNormalFooter {

    public override func prepare() {
        super.prepare()
        
        self.setTitle("", for: .idle)
        self.setTitle("", for: .refreshing)
        self.setTitle("", for: .noMoreData)
        
        self.loadingView?.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
    
}
