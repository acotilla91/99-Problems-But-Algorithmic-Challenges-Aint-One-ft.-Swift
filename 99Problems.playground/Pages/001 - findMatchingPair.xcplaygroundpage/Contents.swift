import Foundation
import XCTest

/*
 
 Find matching pair that's equal to a sum in an ordered or unordered collection.
 Source: https://youtu.be/XKu_SEDAykw
 
 Examples:
 - [1, 2, 3, 8] Sum = 8
 - [1, 2, 4, 4] Sum = 8
 - [1, 3, 5, 8] Sum = 8
 - [1, 3, 4, 5, 7, 8] Sum = 8

*/

// Time complexity: O(n^2)
func findMatchingPairInUnorderedCollectionUsingQuadraticSearch(_ collection: [Int], targetSum: Int) -> [Int]? {
    guard collection.count >= 2 else {
        return nil
    }
    
    for i in 0..<collection.count - 1 {
        let v1 = collection[i]
        for j in (i + 1)...collection.count - 1 {
            let v2 = collection[j]
            if v1 + v2 == targetSum {
                let pair = [v1, v2]
                return pair
            }
        }
    }
    
    return nil
}

// Time complexity: O(n)
// Hash tables search and insertion have a time complexity of O(1)
func findMatchingPairInUnorderedCollectionUsingHashTable(_ collection: [Int], targetSum: Int) -> [Int]? {
    guard collection.count >= 2 else {
        return nil
    }

    var complementsTable: [Int: Int] = [:]
    for value in collection {
        let complement = targetSum - value
        if let _ = complementsTable[complement] {
            return [complement, value]
        }
        else {
            complementsTable[value] = complement
        }
    }
    
    return nil
}

// Time complexity: O(n log(n))
func findMatchingPairInOrderedCollectionUsingBinarySearch(_ collection: [Int], targetSum: Int) -> [Int]? {
    guard collection.count >= 2, collection[0] < targetSum else {
        return nil
    }
    
    for i in 0..<collection.count - 1 {
        let lesserValue = collection[i]
        let greaterValue = targetSum - lesserValue
        
        if let index = binarySearch(collection, value: greaterValue, range: i..<collection.count), index != i {
            return [lesserValue, greaterValue]
        }
    }
    
    return nil
}

// Time complexity: O(log(n))
func binarySearch<T: Comparable>(_ collection: [T], value: T, range: Range<Int>) -> Int? {
    guard range.lowerBound < range.upperBound else {
        return nil
    }
    
    let midIndex = range.lowerBound + (range.upperBound - range.lowerBound) / 2
    let midValue = collection[midIndex]
    if midValue < value {
        return binarySearch(collection, value: value, range: midIndex + 1 ..< range.upperBound)
    }
    else if midValue > value {
        return binarySearch(collection, value: value, range: range.lowerBound ..< midIndex)
    }
    else {
        return midIndex
    }
}

// Time complexity: O(n)
func findMatchingPairInOrderedCollectionUsingLinearSearch(_ collection: [Int], targetSum: Int) -> [Int]? {
    guard collection.count >= 2, collection[0] < targetSum else {
        return nil
    }
    
    var lesserIndex = 0
    var greaterIndex = collection.count - 1
    while lesserIndex < greaterIndex {
        let lesserValue = collection[lesserIndex]
        let greaterValue = collection[greaterIndex]
        if lesserValue + greaterValue == targetSum {
            return [lesserValue, greaterValue]
        }
        else if lesserValue + greaterValue > targetSum {
            greaterIndex -= 1
        }
        else {
            lesserIndex += 1
        }
    }

    return nil
}

// Run tests
XCTAssertEqual(findMatchingPairInUnorderedCollectionUsingQuadraticSearch([1, 5, 3, 8], targetSum: 8), [5, 3])
XCTAssertEqual(binarySearch([1, 3, 5, 8], value: 8, range: 0 ..< 4), 3)
XCTAssertEqual(findMatchingPairInOrderedCollectionUsingBinarySearch([1, 3, 4, 5, 7, 8], targetSum: 7), [3, 4])
XCTAssertEqual(findMatchingPairInOrderedCollectionUsingLinearSearch([1, 3, 4, 5, 7, 8], targetSum: 13), [5, 8])
XCTAssertEqual(findMatchingPairInUnorderedCollectionUsingHashTable([1, 3, 4, 5, 7, 8], targetSum: 12), [5, 7])

print("[\(#file)]: All tests completed successfully!")

