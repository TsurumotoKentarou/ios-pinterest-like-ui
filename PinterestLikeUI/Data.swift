//
//  Data.swift
//  PinterestLikeUI
//
//  Created by 鶴本賢太朗 on 2021/04/19.
//

import Foundation

struct CustomData: Identifiable {
    var id: String = UUID().uuidString
    var content: String = ""
}

class DataFactory {
    static func datas() -> [CustomData] {
        var datas: [CustomData] = []
        for _ in 0 ..< 1 {
            var data: CustomData = .init()
            data.content = randomString(length: 100)
            datas.append(data)
        }
        return datas
    }
    
    static func randomString(length: Int) -> String {

        let letters : NSString = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        let len = UInt32(letters.length)

        var randomString = ""

        for _ in 0 ..< length {
            let rand = arc4random_uniform(len)
            var nextChar = letters.character(at: Int(rand))
            randomString += NSString(characters: &nextChar, length: 1) as String
        }

        return randomString
    }
}


