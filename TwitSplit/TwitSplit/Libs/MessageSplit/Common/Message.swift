//
//  Message.swift
//  TwitSplit
//
//  Created by tri dang huu on 4/8/18.
//  Copyright © 2018 tri dang huu. All rights reserved.
//

import Foundation

public struct Message {
//    let time: NSNumber
    let content: String
    let index:Int
    let total:Int
    
    
    init(content: String, index:Int = 1, total:Int = 1) {
//        self.time = time
        self.content = content
        self.index = index
        self.total = total
    }
}

extension Message {
    func toString() -> String {
        if total > 1 {
            return "\(index)/\(total) \(content)"
        }
        return content
    }
}
