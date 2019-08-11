//
//  IndicatorInfoController.swift
//  DotaGuide
//
//  Created by macOS on 8/3/19.
//  Copyright © 2019 Concung. All rights reserved.
//


import UIKit
import XLPagerTabStrip

class IndicatorInfoController: UIViewController, IndicatorInfoProvider {
    
    var itemInfo: IndicatorInfo {
        return IndicatorInfo(title: "Heroes", image: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    // MARK: - IndicatorInfoProvider
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return itemInfo
    }
}
