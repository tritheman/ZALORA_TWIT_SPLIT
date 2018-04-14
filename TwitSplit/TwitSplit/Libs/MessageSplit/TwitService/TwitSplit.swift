//
//  TwitSplit.swift
//  TwitSplit
//
//  Created by tri dang huu on 4/8/18.
//  Copyright © 2018 tri dang huu. All rights reserved.
//

import Foundation

protocol TwitSplitProtocol {
    func process(message: Message) -> TwitResult
}

class TwitSplit {
    let configuration: TwitConfiguration
    
    // MARK: - Init
    init(configuration: TwitConfiguration = TwitConfiguration()) {
        self.configuration = configuration
    }
}

extension TwitSplit:TwitSplitProtocol {
    
    //Convenient Singleton boject
    public static var shared:TwitSplit = TwitSplit(configuration: TwitConfiguration())
    
    //Main function to extract message into many smaller valid message
    func process(message: Message) -> TwitResult {
        if let error = validateMessage(message) {
            return .DidFailed(error)
        }
        let msg = message.content.trim()
        
        //This message is actually smaller than 50 character. return it immedietly without hesistate.
        if msg.count <= self.configuration.maxCharacter {
            return .DidSuccess([Message(content: msg)])
        }
        
        //start parse message into smaller components
        let result = self.processTwitComponents(message: msg)
        
        //at times when we try to including Index string for example 1/10 with a character that have 48 characters(totally 53 character including a whitespace). => in this case we will handle it as an Ivalid message(The specification doesn't include this case yet).
        if result.Error != nil {
            return .DidFailed(result.Error!)
        }
        
        //If the result return no messages. So there maybe some error when we trying to parse the message. return as unknown error.
        guard let twitList = result.twitList else {
            return .DidFailed(.UnknownError)
        }
        
        let twits = twitList.components.map { (component) -> Message in
            return component.object.toMessageObj()
        }
        
        return .DidSuccess(twits)
    }
}

extension TwitSplit:TwitValidateProtocol {
    //Validate Message
    func validateMessage(_ message: Message) -> TwitError? {
        let msg = message.content.trim()
        if msg.isEmpty {
            return TwitError.Empty
        }
        let result = self.validateMaxLengthCharater(message: msg)
        return result
    }
    
    fileprivate func validateMaxLengthCharater (message: String) -> TwitError? {
        let words = message.components(separatedBy: self.configuration.validCharacterSet)
        
        guard words.first(where: {$0.count > self.configuration.maxCharacter}) == nil else {
            return TwitError.ExceedMaxLength
        }
        return nil
    }

}


