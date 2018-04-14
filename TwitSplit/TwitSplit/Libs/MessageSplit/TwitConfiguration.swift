//
//  TwitConfiguration.swift
//  TwitSplit
//
//  Created by tri dang huu on 4/8/18.
//  Copyright © 2018 tri dang huu. All rights reserved.
//

import UIKit

public protocol TwitConfigProtocol {
    var maxCharacter:Int {get}
    var validCharacterSet:CharacterSet {get}
    
}

open class TwitConfiguration: TwitConfigProtocol {
    public var maxCharacter: Int
    
    public var validCharacterSet: CharacterSet
    
    
    init(max:Int = 50, characterSet:CharacterSet = CharacterSet.whitespacesAndNewlines) {
        self.maxCharacter = max
        self.validCharacterSet = characterSet
    }
}
