//
//  FromHTML.swift
//  DictionaryIOS
//
//  Created by trung quang on 11/20/17.
//  Copyright © 2017 SSD. All rights reserved.
//

internal final class FromHTML {
    class func basicType<FieldType>(_ field: inout FieldType, object: FieldType?) {
        if let value = object {
            field = value
        }
    }
    
    /// Mappable object
    class func object<N: HTMLBaseMappable>(_ field: inout N, map: HTMLMap) {
        let f = HTMLMapper<N>().map(element: map.currentValue as? TFHppleElement)
        if let f = f {
            field = f
        }
    }
    
    /// mappable object array
    class func objectArray<N: HTMLBaseMappable>(_ field: inout Array<N>, map: HTMLMap) {
        field = HTMLMapper<N>().mapArrayObject(elements: map.currentValue as? [TFHppleElement])
    }
}
