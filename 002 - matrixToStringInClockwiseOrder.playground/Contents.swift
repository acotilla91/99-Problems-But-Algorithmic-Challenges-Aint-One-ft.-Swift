import Foundation
import XCTest

/*
 
 Write a function that, given a matrix of integers, builds a string with the entries of that matrix appended in clockwise order.
 
 For instance, the 3x4 matrix below:
 7, 2, 8, 1
 6, 7, 4, 14
 3, 6, 0, 5
 would make the string "7,2,8,1,14,5,0,6,3,6,7,4", from the matrix array: [7, 2, 8, 1, 6, 7, 4, 14, 3, 6, 0, 5]
 
 Parameters given:
 - array: [Int] // 1d matrix
 - numRows: Int
 - numColumns: Int
 
 Sources:
 - GitHub: https://github.com/DauntlessDash/ClockwiseBuildStringFromMatrix
 - Glassdoor: https://www.glassdoor.com/Interview/-Questions-1-You-have-been-given-2-special-extremely-rugged-Xboxes-You-are-in-an-office-building-that-is-120-storie-QTN_851085.htm
 
 */

enum Direction {
    case right
    case down
    case left
    case up
    
    var isHorizontal: Bool {
        return self == .right || self == .left
    }
    
    var isVertical: Bool {
        return self == .up || self == .down
    }
    
    func next() -> Direction {
        switch self {
        case .right:
            return .down
        case .down:
            return .left
        case .left:
            return .up
        case .up:
            return .right
        }
    }
        
    func step(for numberOfColumns: Int) -> Int {
        switch self {
        case .right:
            return 1
        case .down:
            return numberOfColumns
        case .left:
            return -1
        case .up:
            return -numberOfColumns
        }
    }
}

// Time complexity: O(n)
func buildStringFromMatrix(array: [Int], numberOfRows: Int, numberOfColumns: Int) -> String {
    var direction = Direction.right
    var horizontalAdvances = numberOfColumns
    var verticalAdvances = numberOfRows
    var matrixString = ""
    
    var index = 0
    var totalCount = 0
    var remainingAdvances = direction.isHorizontal ? horizontalAdvances : verticalAdvances
    while totalCount < array.count {
        let number = array[index]
        matrixString += index == 0 ? "\(number)" : ",\(number)"
        totalCount += 1
        remainingAdvances -= 1
        
        // Switch direction if necessary
        if (remainingAdvances == 0) {
            direction = direction.next()
            
            if direction.isHorizontal {
                horizontalAdvances -= 1
            }
            else {
                verticalAdvances -= 1
            }
            
            remainingAdvances = direction.isHorizontal ? horizontalAdvances : verticalAdvances
        }
        
        index += direction.step(for: numberOfColumns)
    }
    
    return matrixString
}

/*
 3x4 Matrix:
     7, 2, 8, 1
     6, 7, 4, 14
     3, 6, 0, 5
 
    [7, 2, 8, 1, 6, 7, 4, 14, 3, 6, 0, 5] -> "7,2,8,1,14,5,0,6,3,6,7,4"
 */
let _3x4Matrix1DArray = [7, 2, 8, 1, 6, 7, 4, 14, 3, 6, 0, 5]
let _3x4MatrixStringClockwised = buildStringFromMatrix(array: _3x4Matrix1DArray, numberOfRows: 3, numberOfColumns: 4)
XCTAssertEqual("7,2,8,1,14,5,0,6,3,6,7,4", _3x4MatrixStringClockwised)

/*
 4x4 Matrix:
     7, 2, 8, 1
     6, 7, 4, 14
     3, 6, 0, 5
     11, 4, 7, 3
 
     [7, 2, 8, 1, 6, 7, 4, 14, 3, 6, 0, 5, 11, 4, 7, 3] -> "7,2,8,1,14,5,3,7,4,11,3,6,7,4,0,6"
 */
let _4x4Matrix1DArray = [7, 2, 8, 1, 6, 7, 4, 14, 3, 6, 0, 5, 11, 4, 7, 3]
let _4x4MatrixStringClockwised = buildStringFromMatrix(array: _4x4Matrix1DArray, numberOfRows: 4, numberOfColumns: 4)
XCTAssertEqual("7,2,8,1,14,5,3,7,4,11,3,6,7,4,0,6", _4x4MatrixStringClockwised)
