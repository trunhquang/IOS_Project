//
//  ItemAPI.swift
//  DotaGuide
//
//  Created by macOS on 8/24/19.
//  Copyright © 2019 Concung. All rights reserved.
//

class  ItemAPI {
    static let baseURL = "http://www.playcybergames.com/dota/items.php?item="
    
    static func parsel(key: String, complete: (_ object: Items?) -> Void){
        guard let url = URL(string: "\(ItemAPI.baseURL)\(key)") else {
            complete(nil)
            return
        }
        
        do {
            let data = try Data(contentsOf: url)
            let tFHppleObject = TFHpple(htmlData: data)
            let heroes = HTMLMapper<Items>().map(tFHpple: tFHppleObject)
            complete(heroes)
        } catch {
            complete(nil)
        }
    }
    
    static func getAllItemsID(complete: (_ object: ItemIds?) -> Void){
        guard let url = URL(string: "\(ItemAPI.baseURL)\(1)") else {
            complete(nil)
            return
        }
        
        do {
            let data = try Data(contentsOf: url)
            let tFHppleObject = TFHpple(htmlData: data)
            let items = HTMLMapper<ItemIds>().map(tFHpple: tFHppleObject)
            complete(items)
        } catch {
            complete(nil)
        }
    }
}

