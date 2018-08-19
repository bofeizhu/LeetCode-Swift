/// 66. Plus One
/// Given a non-empty array of digits representing a non-negative integer, plus one to the integer.
/// The digits are stored such that the most significant digit is at the head of the list, and each
/// element in the array contain a single digit.
/// You may assume the integer does not contain any leading zero, except the number 0 itself.

import XCTest

/// Approach: Math
func plusOne(_ digits: [Int]) -> [Int] {
    var digits = digits
    var carry = 1
    for i in stride(from: digits.count - 1, through: 0, by: -1) {
        digits[i] += carry
        if digits[i] > 9 {
            digits[i] = digits[i] % 10
            carry = 1
        } else {
            carry =  0
        }
    }
    if carry == 1 {
        digits.insert(1, at: 0)
    }
    return digits
}

class Tests: XCTestCase {
    func testExample() {
        let digits = [1, 2, 3]
        XCTAssertEqual(plusOne(digits), [1, 2, 4])
    }
}

Tests.defaultTestSuite.run()
