//
//  LFGRefreshHeader.swift
//  CTBaseUIWidget
//
//  Created by walker on 2021/3/9.
//

import Foundation
import MJRefresh

public class LFGRefreshHeader: MJRefreshNormalHeader {
    public override func prepare() {
        super.prepare()
        
        self.lastUpdatedTimeLabel?.isHidden = true
    }
}
