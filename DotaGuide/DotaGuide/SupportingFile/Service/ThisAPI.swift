//
//  ThisAPI.swift
//  DotaGuide
//
//  Created by macOS on 8/3/19.
//  Copyright © 2019 Concung. All rights reserved.
//

import  UIKit

class  ThisAPI {
    static let baseURL = "http://www.playcybergames.com/dota/heroes.php?hero="
    
    static func search(key: String, complete: (_ object: Heroes?) -> Void){
        guard let url = URL(string: "\(ThisAPI.baseURL)\(key)") else {
            complete(nil)
            return
        }
      
        do {
            let data = try Data(contentsOf: url)
            let tFHppleObject = TFHpple(htmlData: data)
            let heroes = HTMLMapper<Heroes>().map(tFHpple: tFHppleObject)
            complete(heroes)
        } catch {
            complete(nil)
        }
    }
    
    static func getAllHeroID(complete: (_ object: Heroids?) -> Void){
        guard let url = URL(string: "\(ThisAPI.baseURL)\(1)") else {
            complete(nil)
            return
        }
        
        do {
            let data = try Data(contentsOf: url)
            let tFHppleObject = TFHpple(htmlData: data)
            let heroes = HTMLMapper<Heroids>().map(tFHpple: tFHppleObject)
            complete(heroes)
        } catch {
            complete(nil)
        }
    }
}

