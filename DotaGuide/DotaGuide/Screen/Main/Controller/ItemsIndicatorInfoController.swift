//
//  ItemsIndicatorInfoController.swift
//  DotaGuide
//
//  Created by macOS on 8/3/19.
//  Copyright © 2019 Concung. All rights reserved.
//

import UIKit
import XLPagerTabStrip
import FirebaseDatabase

class ItemsIndicatorInfoController: IndicatorInfoController {
    var itemsRef = Database.database().reference(withPath: "Items")

    override var itemInfo: IndicatorInfo {
        return IndicatorInfo(title: "Items", image: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        itemsRef.observe(.value) {[weak self] (dataSnapshot) in
            var newItems: [Items] = []
            for child in dataSnapshot.children {
                if let snapshot = child as? DataSnapshot,
                    let groceryItem = Items(snapshot: snapshot) {
                    newItems.append(groceryItem)
                }
            }
            print(newItems.count)
        }
    }
}
