//
//  RefreshStateHeader.swift
//  ArithmeticKit
//
//  Created by Jackie on 8/18/24.
//

import UIKit
import MJRefresh

public class RefreshStateHeader: MJRefreshNormalHeader {

    public override func prepare() {
        super.prepare()
        
        self.setTitle("", for: .idle)
        self.setTitle("", for: .pulling)
        self.setTitle("", for: .refreshing)
        
        self.lastUpdatedTimeLabel?.isHidden = true
        
        self.arrowView?.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        
        self.loadingView?.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
    
}
