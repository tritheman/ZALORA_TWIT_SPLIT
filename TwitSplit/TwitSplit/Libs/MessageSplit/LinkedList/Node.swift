//
//  Node.swift
//  TwitSplit
//
//  Created by tri dang huu on 4/8/18.
//  Copyright © 2018 tri dang huu. All rights reserved.
//

import Foundation

open class Node<T> {
    public var object:T
    public var nextNode:Node<T>?
    weak var previousNode:Node<T>?
    init(node:T, nextNode:Node<T>? = nil, previousNode:Node<T>? = nil) {
        self.object = node
        self.nextNode = nextNode
        self.previousNode = previousNode
    }
}
