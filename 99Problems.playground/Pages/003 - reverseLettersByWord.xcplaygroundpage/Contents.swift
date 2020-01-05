import Foundation
import XCTest

/*

 Given an array of letters that conform a sentence,
 reverse the order of the words in the sentence.
 Sources:
    - https://interviewing.io/recordings/Java-LinkedIn-1/
    - https://www.youtube.com/watch?v=aotBpjJUqJo
 
 Example:
 in: ["p", "e", "r", "f", "e", "c", "t", " ", "m", "a", "k", "e", "s", " ", "p", "r", "a", "c", "t", "i", "c", "e"]
 out: ["p", "r", "a", "c", "t", "i", "c", "e", " ", "m", "a", "k", "e", "s", " ", "p", "e", "r", "f", "e", "c", "t"]

*/

// Time complexity: O(n^2)
// Immutable solution.
// Iterate the orginal letters array backwards and insert each letter in a new array at their respective "word index".
func arrayByReversingLettersByWord(letters: [String]) -> [String] {
    var reversedLetters: [String] = []
    
    var wordIndex = 0
    for i in stride(from: letters.count - 1, through: 0, by: -1) {
        let letter = letters[i]
        if letter != " " {
            reversedLetters.insert(letter, at: wordIndex) // O(n)
        }
        else {
            // Space encountered. Mark the new word index.
            reversedLetters.append(" ")
            wordIndex = reversedLetters.count
        }
    }
    
    return reversedLetters
}

// Time complexity: O(n^2)
// Mutable (in-place) solution.
// Delete last in the orginal letters array on each iteration and insert it back at its respective "word index".
func reverseLettersByWord(letters: inout [String]) {
    var wordIndex = 0
    for prevCount in 0..<letters.count {
        let letter = letters.popLast()!
        if letter != " " {
            letters.insert(letter, at: wordIndex) // O(n)
        }
        else {
            // Space encountered. Mark the new word index.
            letters.insert(" ", at: prevCount) // O(n)
            wordIndex = prevCount + 1
        }
    }
}

// Time complexity: O(n)
// Mutable (in-place) solution. Solution implemented in the interview.
// Reverse all the letters in the array and then reverse back each word.
func reverseLettersByWord_Optim(letters: inout [String]) {
    // Reverse all letters in array.
    letters.reverse()
    
    // Reverse words in array.
    var wordIndex = 0
    var wordLength = 0
    for letter in letters {
        // Increment current word length until a space is found.
        if letter != " " {
            wordLength += 1
        }
        
        // End of current word reached. Reverse letters based on the word location.
        let isLastLetter = wordIndex + wordLength == letters.count
        if letter == " " || isLastLetter {
            letters.reverse(range: wordIndex..<wordIndex + wordLength)
            
            // Reset values for next word.
            if !isLastLetter {
                wordIndex = wordIndex + wordLength + 1
                wordLength = 0
            }
        }
    }
}

extension Array  {
    mutating func reverse(range: CountableRange<Array.Index>) {
        var lowerBound = range.startIndex
        var upperBound = range.endIndex - 1
        while lowerBound < upperBound {
            let lowerElement = self[lowerBound]
            let upperElement = self[upperBound]
            self[lowerBound] = upperElement
            self[upperBound] = lowerElement
            lowerBound += 1
            upperBound -= 1
        }
    }
}

//
// Run tests
//

// Test 1
var letters = ["p", "e", "r", "f", "e", "c", "t", " ", "m", "a", "k", "e", "s", " ", "p", "r", "a", "c", "t", "i", "c", "e"]
let reversedLetters = arrayByReversingLettersByWord(letters: letters)
XCTAssertEqual(reversedLetters, ["p", "r", "a", "c", "t", "i", "c", "e", " ", "m", "a", "k", "e", "s", " ", "p", "e", "r", "f", "e", "c", "t"])

// Test 2
letters = ["p", "e", "r", "f", "e", "c", "t", " ", "m", "a", "k", "e", "s", " ", "p", "r", "a", "c", "t", "i", "c", "e"]
reverseLettersByWord(letters: &letters)
XCTAssertEqual(letters, ["p", "r", "a", "c", "t", "i", "c", "e", " ", "m", "a", "k", "e", "s", " ", "p", "e", "r", "f", "e", "c", "t"])

// Test 3
letters = ["p", "e", "r", "f", "e", "c", "t", " ", "m", "a", "k", "e", "s", " ", "p", "r", "a", "c", "t", "i", "c", "e"]
reverseLettersByWord_Optim(letters: &letters)
XCTAssertEqual(letters, ["p", "r", "a", "c", "t", "i", "c", "e", " ", "m", "a", "k", "e", "s", " ", "p", "e", "r", "f", "e", "c", "t"])

print("[\(#file)]: All tests completed successfully!")

