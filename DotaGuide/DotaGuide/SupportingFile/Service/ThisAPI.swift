//
//  ThisAPI.swift
//  DotaGuide
//
//  Created by macOS on 8/3/19.
//  Copyright © 2019 Concung. All rights reserved.
//

import  UIKit

class  ThisAPI {
    static let baseURL = "http://www.playcybergames.com/dota/heroes.php?hero=1"
    
    static func search(key: String, complete: (_ object: Heroes?) -> Void){
        let tutorialURL = URL(string: "\(ThisAPI.baseURL)\(key)")
        do {
            let data = try Data(contentsOf: tutorialURL!)
            let tFHppleObject = TFHpple(htmlData: data)
            let heroes = HTMLMapper<Heroes>().map(tFHpple: tFHppleObject)
            complete(heroes)
        } catch {
            complete(nil)
        }
    }
    
    static func searchSuggest(key: String, complete: (_ suggests: [String]) -> Void){
        
    }
}

