//
//  JinMap.swift
//  DictionaryIOS
//
//  Created by trung quang on 11/20/17.
//  Copyright © 2017 SSD. All rights reserved.
//

enum MapFrom {
    case TFHpple 
    case TFHppleElement
    case None
}

enum MapType {
    case ArrayObject
    case Object
    case Contents // parsel contents Array
    case Content(Int)
    case Attributes(String)
    case Attribute(String, Int)
//    case TFHppleElement
}

final class HTMLMap {
    var currentValue: Any?
    var html: TFHpple?
    var tfElement: TFHppleElement?
    
    init(html: TFHpple){
        self.html = html
    }
    
    init(element: TFHppleElement){
        self.tfElement = element
    }
    
    subscript(key: String, mapFrom: MapFrom) -> HTMLMap {
        return map(key: key, mapFrom: mapFrom)
    }
    
    subscript(key: String, mapFrom: MapFrom, isChil: Bool) -> HTMLMap {
        return map(key: key, mapFrom: mapFrom, chil: isChil)
    }
    
    subscript(key: String, mapFrom: MapFrom, mapType: MapType ) -> HTMLMap {
        return map(key: key, mapFrom: mapFrom, mapType: mapType)
    }
    
    subscript(key: String, mapFrom: MapFrom, mapType: MapType , chil: Bool ) -> HTMLMap {
        return map(key: key, mapFrom: mapFrom, mapType: mapType, chil: chil)
    }
    
    func value<T>() -> T? {
        return currentValue as? T
    }
    
    private func map(key: String, mapFrom: MapFrom, mapType: MapType = .Content(0), chil: Bool = false) -> HTMLMap {
        if html != nil && mapFrom == .TFHpple{
            let nodes = html!.search(withXPathQuery: key)
            setCurrentValue(nodes: nodes, mapType:  mapType)
        } else {
            if tfElement != nil && mapFrom == .TFHppleElement && key != ""{
                setCurrentValue(nodes: tfElement!.search(withXPathQuery: key), mapType: mapType)
            } else {
                if tfElement != nil && mapFrom == .TFHppleElement && key == "" {
                    setCurrentValue(nodes: [tfElement!], mapType: mapType)
                }
            }
        }
        return self
    }
    
    private func setCurrentValue(nodes: [Any]?,  mapType: MapType){
        switch mapType {
        case .Content(let index):
            if index == 0 {
                currentValue = (nodes?.first as? TFHppleElement)?.content ?? ""
            } else {
                if  (nodes?.count ?? 0) > index {
                    let chil = nodes![index] as! TFHppleElement
                    currentValue = chil.content
                } else {
                    currentValue = ""
                }
            }
            break
        case .Contents:
            var contents = [Any]()
            if let nodes  = nodes {
                for node in nodes {
                    contents.append((node as? TFHppleElement)?.content ?? "")
                }
            }
            currentValue = contents
            break
        case .Attributes(let keyValue):
            var contents = [Any]()
            if let nodes  = nodes {
                for node in nodes {
                    let emement = (node as? TFHppleElement)
                    contents.append(emement?.object(forKey: keyValue) ?? "")
                }
            }
            currentValue = contents
            break
        case .Attribute(let keyValue, let index):
            if index == 0 {
                let chil = nodes?.first as? TFHppleElement
                currentValue = chil?.object(forKey: keyValue) ?? ""
            } else {
//                var listChil = nodes
//                if chil {
//                    listChil = (nodes?.first as? TFHppleElement)?.children
//                }
                if  (nodes?.count ?? 0) > index {
                    let chil = nodes![index] as! TFHppleElement
                    currentValue = chil.object(forKey: keyValue) ?? ""
                } else {
                    currentValue = ""
                }
            }
            break
        case .Object:
            currentValue = nodes?.first
            break
        case .ArrayObject:
            currentValue = nodes
            break
        }
    }
    
}
