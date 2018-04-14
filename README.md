# ZALORA_TWIT_SPLIT
This is an assignment for ZALORA interview test

## Requirement 
The product Tweeter allows users to post short messages limited to 50 characters each.
Sometimes, users get excited and write messages longer than 50 characters.
Instead of rejecting these messages, we would like to add a new feature that will split the message into parts and send multiple messages on the user's behalf, all of them meeting the 50 character requirement.

## System
- iOS > 10.3
- Swift 4.0
- Xcode 9.2

## What I've done
- TwitSplit algorithm.
- Unit test.
- Documentation.

## How TwitSplit works?

Using recursive, re-calculate total part, re-render prefix indicator

  - **Step 1:** Condensed whitespaces and newlines characters from input message.
  - **Step 2:** Return original input message if it's less than limit characters.
  - **Step 3:** Estimate total partial before separate.
  - **Step 4:** Seperate input message into individual words by checking each word's length should greater than limit.
  - **Step 5:** Render all partials. 

  ### Render all partials 
  - **Step 5.1:** Append indicator as prefix of partials.
  - **Step 5.2:** Go through individual word.
  - **Step 5.3:** Return In-validate if the length of individual word include indicator greater than limit.
  - **Step 5.4:** Append individual word.
  - **Step 5.5:** After all words had been add into partials. We will validate the total partial.
  				 If the total partial length is larger than the Estimate total partial length (for example: 105 > 10) then we repeat Step 4.


## How To Use TwitSplit

```
let message = "Some message"
let result = TwitSplit.shared.process(message: Message(content: message))
        if case let TwitResult.DidSuccess(messages) = result  {
            //Handle success messages here
        } else if case let TwitResult.DidFailed(error) = result {
            //Handle error Message here
        }
```

## What I haven't finished yet
- TwitSplit clack unit test cases.
	1: One unit test case that message is too long and the totalPartial length > estimatePartial length


