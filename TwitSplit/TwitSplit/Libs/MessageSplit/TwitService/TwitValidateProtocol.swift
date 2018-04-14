//
//  TwitValidateProtocol.swift
//  TwitSplit
//
//  Created by tri dang huu on 4/8/18.
//  Copyright © 2018 tri dang huu. All rights reserved.
//

import Foundation

protocol TwitValidateProtocol {
    func validateMessage(_ message: Message) -> TwitError?
}
