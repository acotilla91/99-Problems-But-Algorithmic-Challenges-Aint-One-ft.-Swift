
# 99 Problems But Algorithmic Challenges Ain't One [ft. Swift]

Compilation of algorithmic challenges from different sources solved in Swift. Each challenge is contained in its own playground.

## Challenge 1: Find matching pair that's equal to a sum

Find matching pair that's equal to a sum in an ordered or unordered collection. Challenge source: https://youtu.be/XKu_SEDAykw

Examples:
- [1, 2, 3, 8] with Sum = 8 -> nil
- [1, 2, 4, 4] with Sum = 8 -> [4, 4]
- [1, 3, 5, 8] with Sum = 8 -> [3, 5]
- [1, 3, 4, 5, 7, 8] with Sum = 12 -> [5, 7]

## Challenge 2: Convert matrix of integers to a string in clockwise order.

Write a function that, given a matrix of integers, builds a string with the entries of that matrix appended in clockwise order. Challenge sources: [github](https://github.com/DauntlessDash/ClockwiseBuildStringFromMatrix) and [glassdoor](https://www.glassdoor.com/Interview/-Questions-1-You-have-been-given-2-special-extremely-rugged-Xboxes-You-are-in-an-office-building-that-is-120-storie-QTN_851085.htm).

For instance, the 3x4 matrix below:
```
7, 2, 8, 1
6, 7, 4, 14
3, 6, 0, 5
```
would make the string `"7,2,8,1,14,5,0,6,3,6,7,4"`, 
from the matrix array: `[7, 2, 8, 1, 6, 7, 4, 14, 3, 6, 0, 5]`
