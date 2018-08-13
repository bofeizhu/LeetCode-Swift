/// 29. Divide Two Integers
/// Given two integers dividend and divisor, divide two integers without using multiplication,
/// division and mod operator. Return the quotient after dividing dividend by divisor.
///
/// - Note:
///     The integer division should truncate toward zero.
///     Both dividend and divisor will be 32-bit signed integers.
///     The divisor will never be 0.
///     Assume we are dealing with an environment which could only store integers within the 32-bit
///     signed integer range: [−231,  231 − 1]. For the purpose of this problem, assume that your
///     function returns 231 − 1 when the division result overflows.

import XCTest

/// Approach: Bitwise Operation
func divide(_ dividend: Int, _ divisor: Int) -> Int {
    var positive = true
    var dividend = dividend
    var divisor = divisor
    if dividend > 0 {
        dividend = ~dividend + 1
    } else {
        positive = !positive
    }
    
    if divisor > 0 {
        divisor = ~divisor + 1
    } else {
        positive = !positive
    }
    
    var result = 0
    while dividend <= divisor {
        var temp = divisor
        var base = -1
        while temp << 1 >= dividend && temp << 1 < temp {
            temp <<= 1
            base <<= 1
        }
        dividend -= temp
        result += base
    }
    if positive {
        guard result != Int32.min else { return Int(Int32.max) }
        result = ~result + 1
    }
    return result
}

class Tests: XCTestCase {
    func testExample1() {
        XCTAssertEqual(divide(10, 3), 3)
    }
    
    func testExample2() {
        XCTAssertEqual(divide(-2147483648, 1), -2147483648)
    }
}

Tests.defaultTestSuite.run()
