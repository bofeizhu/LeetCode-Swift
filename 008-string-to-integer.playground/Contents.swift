/// 8. String to Integer
/// Implement atoi which converts a string to an integer.
///
/// The function first discards as many whitespace characters as necessary until the first
/// non-whitespace character is found. Then, starting from this character, takes an optional initial
/// plus or minus sign followed by as many numerical digits as possible, and interprets them as a
/// numerical value.
///
/// The string can contain additional characters after those that form the integral number, which
/// are ignored and have no effect on the behavior of this function.
///
/// If the first sequence of non-whitespace characters in str is not a valid integral number, or if
/// no such sequence exists because either str is empty or it contains only whitespace characters,
/// no conversion is performed.
///
/// If no valid conversion could be performed, a zero value is returned.
///
/// - Note:
///     Only the space character ' ' is considered as whitespace character.
///     Assume we are dealing with an environment which could only store integers within the 32-bit
///     signed integer range: [−231,  231 − 1]. If the numerical value is out of the range of
///     representable values, INT_MAX (231 − 1) or INT_MIN (−231) is returned.

import XCTest

func myAtoi(_ str: String) -> Int {
    enum State {
        case discardingWhiteSpaces
        case signFounded
        case parsing
        case finish
    }
    
    let dict: [Character: Int] =
        ["0": 0, "1": 1, "2": 2, "3": 3, "4": 4, "5": 5, "6": 6, "7": 7, "8": 8, "9": 9]
    
    var state: State = .discardingWhiteSpaces
    var output = 0
    var sign = 1
    for c in str {
        switch state {
        case .discardingWhiteSpaces:
            if c == " " {
                continue
            } else if c == "-" {
                sign = -1
                state = .signFounded
            } else if c == "+" {
                state = .signFounded
            } else if let n = dict[c] {
                output = n
                state = .parsing
            } else {
                return output
            }
        case .signFounded:
            if let n = dict[c] {
                output = n
                state = .parsing
            } else {
                return output
            }
        case .parsing:
            guard output < Int32.max else {
                state = .finish
                break
            }
            if let n = dict[c] {
                output = output * 10 + n
            } else {
                state = .finish
            }
        case .finish:
            break
        }
        
        guard state != .finish else { break }
    }
    output = output * sign
    guard output < Int32.max else { return Int(Int32.max) }
    guard output > Int32.min else { return Int(Int32.min) }
    return output
}

class Tests: XCTestCase {
    func testExample1() {
        XCTAssertEqual(myAtoi("42"), 42)
    }

    func testExample2() {
        XCTAssertEqual(myAtoi("4193 with words"), 4193)
    }
    
    func testExample3() {
        XCTAssertEqual(myAtoi("3.14159"), 3)
    }
}

Tests.defaultTestSuite.run()
