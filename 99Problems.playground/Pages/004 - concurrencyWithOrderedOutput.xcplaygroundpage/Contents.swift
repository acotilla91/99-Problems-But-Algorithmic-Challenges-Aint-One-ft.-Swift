import Foundation
import XCTest

/*
 
 Without modifying the function `PerformSlowCalculation(_:)`, create an optimized version of
 `ArrayCalculation(_:)` with code that performs the calculation method over the input array
 concurrently using Cocoa concurrency API's: Grand Central Dispatch, NSOperationQueue,
 POSIX pthread, etc.
 The resulting array must maintain the same order as the input array.
 
 */

// This is a calculation function that accepts an Integer as input, and
// returns number * 2 as output. To simulate a lengthy calculation, the
// function blocks for a random time interval from 1 - 2 seconds.
func PerformSlowCalculation(_ i : Int) -> Int {
    let timesTwo = i * 2
    let pause = arc4random_uniform(1) + 2
    sleep(pause)
    return timesTwo
}

// Perform a calculation on each element of the input array of numbers,
// returning an array of the results in the same order as the
// corresponding input array number.
func ArrayCalculation(_ a : [Int]) -> [Int] {
    let values = a.map { PerformSlowCalculation($0) }
    return values
}

func ArrayCalculation_Optim(_ a : [Int]) -> [Int] {
    //  Create array with the expected size
    var newArray: [Int] = Array(repeating: 0, count: a.count)

    let threadSafetyQueue = DispatchQueue(label: "com.challenge.concurrency", attributes: .concurrent)

    // Use DispatchGroup to wait until all operations are done. Wouldn't be necessary if we didn't fire a new thread inside
    // `concurrentPerform()` because `concurrentPerform()` is synchronous.
    let group = DispatchGroup()

    // `DispatchQueue.concurrentPerform` performs multiple operations concurrently.
    //  It is synchronous meaning, that it returns after all operations are done.
    DispatchQueue.concurrentPerform(iterations: a.count) { (index) in
        // Register operation began
        group.enter()

        let number = a[index]
        
        // Perform the slow operation asynchronously since `concurrentPerform()` could limit the amount
        // of concurrent operations.
        DispatchQueue.global().async {
            // Perform slow operation
            let result = PerformSlowCalculation(number)
            
            // Safely write to the array
            threadSafetyQueue.async(flags: .barrier) {
                newArray[index] = result
                
                // Signal operation ended
                group.leave()
            }
        }
    }
    
    // Wait until all tasks are done
    group.wait()

    return newArray
}

// Run tests
let inputArray = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]
let start = NSDate()
let outputArray = ArrayCalculation_Optim(inputArray)
let duration = -start.timeIntervalSinceNow
XCTAssertEqual(outputArray,  [0, 2, 4, 6, 8, 10, 12, 14, 16, 18])

print("[\(#file)]: All tests completed successfully! Duration: \(duration)")
