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
//        itemsRef.observe(.value) {[weak self] (dataSnapshot) in
//            var newItems: [Items] = []
//            for child in dataSnapshot.children {
//                if let snapshot = child as? DataSnapshot,
//                    let groceryItem = Items(snapshot: snapshot) {
//                    newItems.append(groceryItem)
//                }
//            }
//            print(newItems.count)
////            self?.createHeroesData(datas: newItems)
////            self?.setDataSource()
//        }
        ItemAPI.getAllItemsID { (items) in
            if let items = items {
                addHerosToDB(heroesID: items)
            }
        }
        
//        ItemAPI.parsel(key: "113") { (items) in
////            parseHTMLGroup.leave()
////            items?.addToFirebase(id: realID)
//        }
    }
    
    
    func  addHerosToDB(heroesID: ItemIds){
        let parseHTMLGroup = DispatchGroup()
        for id in heroesID.ids {
            if let realID = id.split("/").last?.split(".").first {
                parseHTMLGroup.enter()
                ItemAPI.parsel(key: realID) { (items) in
                    parseHTMLGroup.leave()
                    items?.addToFirebase(id: realID)
                }
            }
        }
        parseHTMLGroup.notify(queue: .main) { [weak self] in
            print("___________________________")
        }
    }
}
