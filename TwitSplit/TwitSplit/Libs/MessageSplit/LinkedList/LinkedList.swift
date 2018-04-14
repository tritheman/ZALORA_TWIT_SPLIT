//
//  LinkedList.swift
//  TwitSplit
//
//  Created by tri dang huu on 4/8/18.
//  Copyright © 2018 tri dang huu. All rights reserved.
//

import Foundation

open class LinkedList<T> {
    public private(set) var head:Node<T>? {
        didSet {
            if tail == nil {
                self.tail = head
                self.tail?.previousNode = nil
            }
        }
    }
    
    public private(set) var tail:Node<T>? {
        didSet {
            if head == nil {
                self.head = tail
                self.head?.previousNode = nil
            }
        }
    }
    
    public private(set) var count:Int = 0
    
    public var isEmpty:Bool {
        return self.count == 0
    }
    
    init(head: Node<T>) {
        self.head = head
    }
    
    init<S: Sequence>(sequence: S) where S.Iterator.Element == T {
        for item in sequence {
            self.append(value: item)
        }
    }
}

extension LinkedList {
    public func append(node: Node<T>) {
        guard let tail = tail else {
            head = node
            count += 1
            return
        }
        
        tail.nextNode = node
        node.previousNode = tail
        self.tail = node
        count += 1
    }
    
    public func append(value:T) {
        self.append(node: Node(node: value))
    }
    
    public func remove(node: Node<T>) {
        let prev = node.previousNode
        let next = node.nextNode
        
        if let prev = prev {
            prev.nextNode = next
        } else {
            head = next
        }
        
        if let next = next {
            next.previousNode = prev
        } else {
            self.tail = prev
        }
        count -= 1
    }
    
    public func nodeAt(index: Int) -> Node<T>? {
        if index < 0 || index >= count {
            return nil
        }
        
        var node = head
        var i = index
        // 2
        while node != nil {
            if i == 0 { return node }
            i -= 1
            node = node!.nextNode
        }
        
        return nil
    }
    
    public func removeAll() {
        head = nil
        tail = nil
    }
}

extension LinkedList {
    
    func mapToArray() -> [T] {
       let arr = self.map { (node) -> T in
            return node.object
        }
        return arr
    }
    
    public func map<E>(_ block: (Node<T>) -> E) -> [E] {
        
        var result: [E] = []
        
        forEach { (node) in
            result.append(block(node))
        }
        
        // Return
        return result
    }
    
    public func forEach(_ block: (Node<T>) -> Void) {

        var currentPointer = head
        while currentPointer != nil {

            // Exec
            block(currentPointer!)

            // Next
            currentPointer = currentPointer?.nextNode
        }
    }
}
