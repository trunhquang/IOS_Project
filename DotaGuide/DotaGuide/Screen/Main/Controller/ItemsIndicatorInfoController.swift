//
//  ItemsIndicatorInfoController.swift
//  DotaGuide
//
//  Created by macOS on 8/3/19.
//  Copyright © 2019 Concung. All rights reserved.
//

import UIKit
import XLPagerTabStrip

class ItemsIndicatorInfoController: IndicatorInfoController {
    
    override var itemInfo: IndicatorInfo {
        return IndicatorInfo(title: "Items", image: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
}
