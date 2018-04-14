//
//  TwitComponent.swift
//  TwitSplit
//
//  Created by tri dang huu on 4/8/18.
//  Copyright © 2018 tri dang huu. All rights reserved.
//

import Foundation

//We create a TwitComponent to act as a container for a valid Parsed Message.
public class TwitComponent {
    var wordList: LinkedList<String>
    var wordCount: Int
    var index:Int
    var totalPage:Int
    
    init(words: [String] = [], index: Int = 0, totalPage:Int = 0) {
        self.wordList = LinkedList<String>(sequence: words)
        self.wordCount = words.map({ (word) -> Int in
            return word.count
        }).reduce(0, +)
        self.index = index
        self.totalPage = totalPage
    }
    
}

extension TwitComponent {
    typealias appendFinished = (exceedCharacter:Bool, Error:TwitError?)
    func append(word: String, max: Int) -> appendFinished {
        
        // Estimate the length of tweet
        let spaceCount = 1
        let indexString = "\(index)/\(totalPage)"
        let lenghthCount = wordCount + word.count + spaceCount + indexString.count
        let singleWordCount = word.count + spaceCount + indexString.count
        
        guard singleWordCount <= max else {
            return appendFinished(exceedCharacter: false, Error: TwitError.ExceedMaxLength)
        }
        guard lenghthCount <= max else {
            return appendFinished(exceedCharacter: true, Error: nil)
        }
        
        wordList.append(value: word)
        wordCount += (word.count + spaceCount)
        
        return appendFinished(exceedCharacter: false, Error: nil)
    }
}

extension TwitComponent {
    func toMessageObj() -> Message {
        let words = self.wordList.mapToArray()
        let wordString = words.joined(separator: " ")
        let message = Message(content: wordString, index: self.index, total: self.totalPage)
        return message
        
    }
}
