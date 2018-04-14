//
//  Builder.swift
//  TwitSplit
//
//  Created by tri dang huu on 4/9/18.
//  Copyright © 2018 tri dang huu. All rights reserved.
//

import UIKit



extension TwitSplit:TwitBuilderProtocol {
    
    func processTwitComponents(message:String) -> TwitComponentResult {
        
        let words = message.components(separatedBy: self.configuration.validCharacterSet)
        
        //Estimate the total page.
        let estTotalPage = (message.count / self.configuration.maxCharacter) + (message.count % self.configuration.maxCharacter > 0 ? 1 : 0)

        //begin to extract our messages to parts.
        let componentResult = self.calculateMessageComponent(estimatePage: estTotalPage, words: words)

        return componentResult
    }
    
    fileprivate func calculateMessageComponent(estimatePage:Int, words:[String]) -> TwitComponentResult {
        
        var currentPage = 1
        var totalPage = 1
        
        //Linked list of components. Each component is represent as a valid message.
        let components = LinkedList<TwitComponent>(sequence: [])
        
        //Create an component(curComponent) - to easier to understand from now on let think that curComponent as current Message.
        var curComponent = TwitComponent(index: currentPage, totalPage: estimatePage)
        
        //We will count each word and add it to the current component.
        var i = 0
        while i < words.count {
            let word = words[i]
            let appendResult = curComponent.append(word: word, max: self.configuration.maxCharacter)
            
            if appendResult.Error != nil {
                return TwitComponentResult(Error: appendResult.Error, twitList:nil)
            }
            
            if appendResult.exceedCharacter {
                //Current Message is have max character. Add it to the linkedList<TwitComponent>
                components.append(value: curComponent)
                //Update the total PAge
                currentPage += 1
                totalPage += 1
                //Create a new Message. And it will become current Message.
                curComponent = TwitComponent(index: currentPage, totalPage: estimatePage)
                //Keep adding work in to the current message until no words left.
                continue
            }
            i += 1
        }
        //Finally we got all me message parsed.
        components.append(value: curComponent)
        
        // This happen when sometime the total page is larger than the estimate page, in this case we will recalcualate the Message components.
        //And it seems like the index string is getting larger in some scenario, even when recalculated message then we will re-calculated the message components until we got the correct result.
        if totalPage > estimatePage {
            //the total page after calculated have more character than the estimate. We will re-calculated the page once a gain.
            if String(totalPage).count > String(estimatePage).count {
                //recursive call until we got the right value.
                let componentResult = self.calculateMessageComponent(estimatePage: totalPage, words: words)
                return componentResult
            } else {
                // if the total page is changed but the length of the total page don't change. Just update the total page for each Message component and return the result.
                components.forEach({ (node) in
                    return node.object.totalPage = totalPage
                })
                return TwitComponentResult(Error:nil, twitList:TwitComponentList(components, totalPage))
            }

        }
        
        //Every thing going well unExpectedly then we just return the value.
        return TwitComponentResult(Error:nil, twitList:TwitComponentList(components, totalPage))
    }
    
}
