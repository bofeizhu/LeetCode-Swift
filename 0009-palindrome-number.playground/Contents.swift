/// 9. Palindrome Number
/// Determine whether an integer is a palindrome. An integer is a palindrome when it reads the same
/// backward as forward.

import XCTest

func isPalindrome(_ x: Int) -> Bool {
    guard x >= 0 else { return false }
    guard x >= 10 else { return true }
    guard x % 10 != 0 else { return false }
    
    var left = x
    var right = 0
    while left > right {
        right = right * 10 + left % 10
        left = left / 10
        if left == right || left / 10 == right { // even digits or odd digits
            return true
        }
    }
    return false
}

class Tests: XCTestCase {
    func testExample1() {
        XCTAssertTrue(isPalindrome(121))
    }
    
    func testExampleZero() {
        XCTAssertTrue(isPalindrome(0))
    }
    
    func testSomethingLong() {
        XCTAssertTrue(isPalindrome(1234554321))
    }
}

Tests.defaultTestSuite.run()
