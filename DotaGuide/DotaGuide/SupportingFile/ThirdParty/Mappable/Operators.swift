//
//  Operators.swift
//  DictionaryIOS
//
//  Created by trung quang on 11/20/17.
//  Copyright © 2017 SSD. All rights reserved.
//

infix operator <-

func <- <T>(left: inout T, right: HTMLMap) {
    FromHTML.basicType(&left, object: right.value())
}

func <- <T>(left: inout Array<T>, right: HTMLMap) {
    FromHTML.basicType(&left, object: right.value())
}

func <- <T: HTMLBaseMappable>(left: inout T, right: HTMLMap) {
    FromHTML.object(&left, map: right)
}

// Array of Mappable objects
func <- <T: HTMLBaseMappable>(left: inout Array<T>, right: HTMLMap) {
    FromHTML.objectArray(&left, map: right)
}

