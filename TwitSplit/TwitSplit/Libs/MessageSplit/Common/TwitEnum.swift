//
//  TwitResult.swift
//  TwitSplit
//
//  Created by tri dang huu on 4/8/18.
//  Copyright © 2018 tri dang huu. All rights reserved.
//

import Foundation
import UIKit

public enum TwitResult {
    case DidSuccess([Message])
    case DidFailed(TwitError)
}

public enum TwitError:Error {
    case UnknownError
    case ExceedMaxLength
    case Empty
    //The message contains a span of non-whitespace characters longer than \(limitCharacters) characters
    
    public var errorString: String {
        switch self {
        case .UnknownError:
            return "Unknowed Error"
        case .ExceedMaxLength:
            return "The message contains a span of non-whitespace characters longer than 50 characters"
        case .Empty:
            return "Empty Message"
        }
    }

}
