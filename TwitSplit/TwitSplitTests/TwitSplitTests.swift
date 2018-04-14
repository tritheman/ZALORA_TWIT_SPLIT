//
//  TwitSplitTests.swift
//  TwitSplitTests
//
//  Created by tri dang huu on 4/13/18.
//  Copyright © 2018 tri dang huu. All rights reserved.
//

import XCTest
@testable import TwitSplit

class TwitSplitTests: XCTestCase {
    
    let twitSplit = TwitSplit.shared
    
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testAssignementMessage() {
        
        // Give
        let input = "I can't believe Tweeter now supports chunking my messages, so I don't have to do it myself."
        let expected = ["1/2 I can't believe Tweeter now supports chunking",
                        "2/2 my messages, so I don't have to do it myself."]
        
        // When
        let result = twitSplit.process(message: Message(content: input))
        let output:[String]
        // The
        switch result {
        case TwitResult.DidFailed(let err):
            XCTFail(err.errorString)
        case TwitResult.DidSuccess(let messages):
            output = messages.map({ (message) -> String in
                return message.toString()
            })
            XCTAssertEqual(output.count, expected.count, "testAssignementMessage: Match Partial Count")
            XCTAssertEqual(output, expected, "testAssignementMessage: Matches case Assignment Message")
        }
    }
    
    func testMaxLenghCharacterMessage() {
        
        // Give
        let input = "Ican'tbelieveTweeternowsupportschunkingmymessages,so I don't have to do it myself."
        let expecErr = TwitError.ExceedMaxLength
        // When
        let result = twitSplit.process(message: Message(content: input))
        //        let output:[String]
        // The
        switch result {
        case TwitResult.DidFailed(let err):
            XCTAssertEqual(expecErr.errorString , err.errorString, "testMaxLenghtCharacterMessage: Match expected result")
        case TwitResult.DidSuccess( _):
            XCTFail("testMaxLenghtCharacterMessage: doesn't match expected result")
        }
    }
    
    func testWhiteSpaceMessage() {
        
        // Give
        let input = "        "
        let expecErr = TwitError.Empty
        // When
        let result = twitSplit.process(message: Message(content: input))
//        let output:[String]
        // The
        switch result {
        case TwitResult.DidFailed(let err):
            XCTAssertEqual(expecErr.errorString , err.errorString, "testWhiteSpaceMessage: Match expected result")
        case TwitResult.DidSuccess( _):
            XCTFail("testWhiteSpaceMessage: doesn't match expected result")
        }
    }
    
    func testMaxLenghWhenIndexingMessage() {
        
        // Give
        let input = "Ican'tbelieveTweeternowsupportschunkingmymessages, so I don't have to do it myself."
        let expecErr = TwitError.ExceedMaxLength
        // When
        let result = twitSplit.process(message: Message(content: input))
        //        let output:[String]
        // The
        switch result {
        case TwitResult.DidFailed(let err):
            XCTAssertEqual(expecErr.errorString , err.errorString, "testMaxLenghWhenIndexingMessage: Match expected result")
        case TwitResult.DidSuccess( _):
            XCTFail("testMaxLenghtCharacterMessage: doesn't match expected result")
        }
    }
    
    func testValidShortMessage() {
        
        // Give
        let input = "I can't believe Tweeter now supports chunking"
        let expected = ["I can't believe Tweeter now supports chunking"]
        
        // When
        let result = twitSplit.process(message: Message(content: input))
        let output:[String]
        // The
        switch result {
        case TwitResult.DidFailed(let err):
            XCTFail(err.errorString)
        case TwitResult.DidSuccess(let messages):
            output = messages.map({ (message) -> String in
                return message.toString()
            })
            XCTAssertEqual(output.count, expected.count, "testValidShortMessage: Match Partial Count")
            XCTAssertEqual(output, expected, "testValidShortMessage: Matches expected case")
        }
    }
    
    func testBoundaryCharacterAtMaxIndexMessage() {
        
        // Give
        let input = "I can't believe Tweeter now supports chunkingmyMEssage, so i don't have to do it mannually"
        let expected = [
        "1/3 I can\'t believe Tweeter now supports",
        "2/3 chunkingmyMEssage, so i don\'t have to do it",
        "3/3 mannually"
        ]
        
        // When
        let result = twitSplit.process(message: Message(content: input))
        let output:[String]
        // The
        switch result {
        case TwitResult.DidFailed(let err):
            XCTFail(err.errorString)
        case TwitResult.DidSuccess(let messages):
            output = messages.map({ (message) -> String in
                return message.toString()
            })
            XCTAssertEqual(output.count, expected.count, "testBoundaryCharacterAtMaxIndexMessage: Match Partial Count")
            XCTAssertEqual(output, expected, "testBoundaryCharacterAtMaxIndexMessage: Matches expected case")
        }
    }
    
    func testMultipleWhitespaceConsistence() {
        // Give
        let input = "this     is     a   \n\n\n  possible     input"
        let expected = ["this is a possible input"]
        
        // When
        let result = twitSplit.process(message: Message(content: input))
        let output:[String]
        // The
        switch result {
        case TwitResult.DidFailed(let err):
            XCTFail(err.errorString)
        case TwitResult.DidSuccess(let messages):
            output = messages.map({ (message) -> String in
                return message.toString()
            })
            XCTAssertEqual(output.count, expected.count, "testMultipleWhitespaceConsistence: Match Partial Count")
            XCTAssertEqual(output, expected, "testMultipleWhitespaceConsistence: Matches expected case")
        }
    }
    
    func testAValidRandomMessage() {
        
        // Give
        let input = """
In GameplayKit, you subclass GKState to define each state and the rules for allowed transitions between states, and use a GKStateMachine instance to manage a machine that combines several states. This system provides a way to organize code in your game by organizing state-dependent actions into methods that run when entering a state, when exiting a state, and periodically while in a state (for example, on every animation frame your game renders).

You can use state machines to govern various aspects of a game. For example:

An enemy character might use a state machine with Chase, Flee, Dead, and Respawn states, each of which drives the enemy’s behavior, with state transitions determined by player actions and elapsed time.

An automated turret might use a state machine with Ready, Firing, and Cooldown states, controlling when it seeks out nearby targets and how often it fires.

A game user interface might use Menu, Playing, Paused, and GameOver states, each of which determines what UI elements are shown and what other game elements are running.

To build a state machine, first define a distinct subclass of GKState for each possible state of the machine. In each state class, the isValidNextState(_:) method determines which other state classes the machine may transition into from that state. Then, create a state machine object by constructing instances of the state classes and passing them to one of the methods listed in Creating a State Machine. Finally, set the machine in motion by choosing an initial state for it to enter with the enter(_:) method.

To define state-dependent behavior, override the didEnter(from:), update(deltaTime:), and willExit(to:) methods in each GKState subclass.

The state machine notifies the current state whenever a state change happens. Use the didEnter(from:) and willExit(to:) methods to perform actions in response to a state change. For example, an enemy character entering the Flee state might change its appearance to indicate that is has become vulnerable to attack by the player.

When you call a state machine’s update(deltaTime:) method, the state machine calls the update(deltaTime:) method of its current state. Use this method to organize per-frame update code by state. For example, an enemy character in the Chase state can update its position to pursue the player, and an enemy in the Flee state can update its position to evade the player.

For more information about state machines, read State Machines in GameplayKit Programming Guide.
"""
        let expected = ["1/60 In GameplayKit, you subclass GKState to",
                        "2/60 define each state and the rules for allowed",
                        "3/60 transitions between states, and use a",
                        "4/60 GKStateMachine instance to manage a machine",
                        "5/60 that combines several states. This system",
                        "6/60 provides a way to organize code in your game",
                        "7/60 by organizing state-dependent actions into",
                        "8/60 methods that run when entering a state, when",
                        "9/60 exiting a state, and periodically while in a",
                        "10/60 state (for example, on every animation frame",
                        "11/60 your game renders).  You can use state",
                        "12/60 machines to govern various aspects of a",
                        "13/60 game. For example:  An enemy character might",
                        "14/60 use a state machine with Chase, Flee, Dead,",
                        "15/60 and Respawn states, each of which drives the",
                        "16/60 enemy’s behavior, with state transitions",
                        "17/60 determined by player actions and elapsed",
                        "18/60 time.  An automated turret might use a state",
                        "19/60 machine with Ready, Firing, and Cooldown",
                        "20/60 states, controlling when it seeks out nearby",
                        "21/60 targets and how often it fires.  A game user",
                        "22/60 interface might use Menu, Playing, Paused,",
                        "23/60 and GameOver states, each of which",
                        "24/60 determines what UI elements are shown and",
                        "25/60 what other game elements are running.  To",
                        "26/60 build a state machine, first define a",
                        "27/60 distinct subclass of GKState for each",
                        "28/60 possible state of the machine. In each state",
                        "29/60 class, the isValidNextState(_:) method",
                        "30/60 determines which other state classes the",
                        "31/60 machine may transition into from that state.",
                        "32/60 Then, create a state machine object by",
                        "33/60 constructing instances of the state classes",
                        "34/60 and passing them to one of the methods",
                        "35/60 listed in Creating a State Machine. Finally,",
                        "36/60 set the machine in motion by choosing an",
                        "37/60 initial state for it to enter with the",
                        "38/60 enter(_:) method.  To define state-dependent",
                        "39/60 behavior, override the didEnter(from:),",
                        "40/60 update(deltaTime:), and willExit(to:)",
                        "41/60 methods in each GKState subclass.  The state",
                        "42/60 machine notifies the current state whenever",
                        "43/60 a state change happens. Use the",
                        "44/60 didEnter(from:) and willExit(to:) methods to",
                        "45/60 perform actions in response to a state",
                        "46/60 change. For example, an enemy character",
                        "47/60 entering the Flee state might change its",
                        "48/60 appearance to indicate that is has become",
                        "49/60 vulnerable to attack by the player.  When",
                        "50/60 you call a state machine’s",
                        "51/60 update(deltaTime:) method, the state machine",
                        "52/60 calls the update(deltaTime:) method of its",
                        "53/60 current state. Use this method to organize",
                        "54/60 per-frame update code by state. For example,",
                        "55/60 an enemy character in the Chase state can",
                        "56/60 update its position to pursue the player,",
                        "57/60 and an enemy in the Flee state can update",
                        "58/60 its position to evade the player.  For more",
                        "59/60 information about state machines, read State",
                        "60/60 Machines in GameplayKit Programming Guide."]
        
        // When
        let result = twitSplit.process(message: Message(content: input))
        let output:[String]
        // The
        switch result {
        case TwitResult.DidFailed(let err):
            XCTFail(err.errorString)
        case TwitResult.DidSuccess(let messages):
            output = messages.map({ (message) -> String in
                return message.toString()
            })
            XCTAssertEqual(output.count, expected.count, "testAValidRandomMessage: Match Partial Count")
            XCTAssertEqual(output, expected, "testAValidRandomMessage: Matches expected result")
        }
    }
    
    func testCustomIndexStringMessage() {

        let customTwiSplit = TwitSplit(configuration: TwitConfiguration(max: 30, characterSet: CharacterSet(charactersIn: "_")))

        // Give
        let input = "I_can't_believe_Tweeter_now_supports_chunking_my_messages,_so_I_don't_have_to_do_it_myself."
        let expected = [
            "1/4 I can\'t believe Tweeter",
            "2/4 now supports chunking my",
            "3/4 messages, so I don\'t have",
            "4/4 to do it myself."
        ]
        
        // When
        let result = customTwiSplit.process(message: Message(content: input))
        let output:[String]
        // The
        switch result {
        case TwitResult.DidFailed(let err):
            XCTFail(err.errorString)
        case TwitResult.DidSuccess(let messages):
            output = messages.map({ (message) -> String in
                return message.toString()
            })
            XCTAssertEqual(output.count, expected.count, "testCustomIndexStringMessage: Match Partial Count")
            XCTAssertEqual(output, expected, "testCustomIndexStringMessage: Matches expected case")
        }
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
