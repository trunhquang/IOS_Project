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
    case BaseArray
    case ArrayObject
    case Object
    case Content
    case Attribute
}

final class HTMLMap {
    internal(set) var currentValue: Any?
    internal(set) var html: TFHpple?
    internal(set) var tfElement: TFHppleElement?
    
    init(html: TFHpple){
        self.html = html
    }
    
    init(element: TFHppleElement){
        self.tfElement = element
    }
    
    subscript(key: String, mapFrom: MapFrom) -> HTMLMap {
        return map(key: key, mapFrom: mapFrom)
    }
    
    subscript(key: String, mapFrom: MapFrom, index: Int, isChil: Bool) -> HTMLMap {
        return map(key: key, mapFrom: mapFrom, index: index, chil: isChil)
    }
    
    subscript(key: String, mapFrom: MapFrom, mapType: MapType ) -> HTMLMap {
        return map(key: key, mapFrom: mapFrom, mapType: mapType)
    }
    
    subscript(key: String, mapFrom: MapFrom, mapType: MapType , keyValue: String, index: Int, chil: Bool ) -> HTMLMap {
        return map(key: key, mapFrom: mapFrom, mapType: mapType, keyValue: keyValue, index: index, chil: chil)
    }
    
    subscript(key: String, mapFrom: MapFrom, mapType: MapType , keyValue: String ) -> HTMLMap {
        return map(key: key, mapFrom: mapFrom, mapType: mapType, keyValue: keyValue)
    }
    
    func value<T>() -> T? {
        return currentValue as? T
    }
    
    private func map(key: String, mapFrom: MapFrom, mapType: MapType = .Content, keyValue: String = "", index: Int = 0, chil: Bool = false) -> HTMLMap {
        if html != nil && mapFrom == .TFHpple{
            let nodes = html!.search(withXPathQuery: key)
            setCurrentValue(nodes: nodes, mapType:  mapType, keyValue: keyValue)
        } else {
            if tfElement != nil && mapFrom == .TFHppleElement && key != ""{
                setCurrentValue(nodes: tfElement!.search(withXPathQuery: key), mapType: mapType, keyValue: keyValue, index: index, chil: chil)
            } else {
                if tfElement != nil && mapFrom == .TFHppleElement && key == "" {
                    setCurrentValue(nodes: [tfElement!], mapType: mapType, keyValue: keyValue, index: index, chil: chil)
                }
            }
        }
        return self
    }
    
    private func setCurrentValue(nodes: [Any]?,  mapType: MapType, keyValue: String, index:  Int = 0, chil: Bool = false){
        switch mapType {
        case .Content:
            if index == 0 {
                currentValue = (nodes?.first as? TFHppleElement)?.content ?? ""
            } else {
                var listChil = nodes
                if chil {
                    listChil = (nodes?.first as? TFHppleElement)?.children
                }
                if  (listChil?.count ?? 0) > index {
                    let chil = listChil![index] as! TFHppleElement
                    currentValue = chil.content
                } else {
                    currentValue = ""
                }
            }
            break
        case .Attribute:
            if index == 0 {
                let chil = nodes?.first as? TFHppleElement
                currentValue = chil?.object(forKey: keyValue) ?? ""
            } else {
                var listChil = nodes
                if chil {
                    listChil = (nodes?.first as? TFHppleElement)?.children
                }
                if  (listChil?.count ?? 0) > index {
                    let chil = listChil![index] as! TFHppleElement
                    currentValue = chil.object(forKey: keyValue) ?? ""
                } else {
                    currentValue = ""
                }
            }
            break
        case .Object:
            currentValue = nodes?.first
            break
        case .BaseArray:
            var contents = [Any]()
            if let nodes  = nodes {
                for node in nodes {
                    contents.append((node as? TFHppleElement)?.content ?? "")
                }
            }
            currentValue = contents
            break
        case .ArrayObject:
            currentValue = nodes
            break
        }
    }
    
}
