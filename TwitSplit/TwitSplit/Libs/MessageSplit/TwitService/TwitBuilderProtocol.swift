//
//  TwitBuilderProtocol.swift
//  TwitSplit
//
//  Created by tri dang huu on 4/8/18.
//  Copyright © 2018 tri dang huu. All rights reserved.
//

import Foundation
public typealias TwitComponentList = (components:LinkedList<TwitComponent>, totalPage:Int)
public typealias TwitComponentResult = (Error:TwitError?, twitList:TwitComponentList?)

protocol TwitBuilderProtocol {
    func processTwitComponents(message:String) -> TwitComponentResult
}

