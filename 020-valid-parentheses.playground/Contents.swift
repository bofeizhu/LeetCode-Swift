/// 20. Valid Parentheses
/// Given a string containing just the characters '(', ')', '{', '}', '[' and ']', determine if the
/// input string is valid.
///
/// An input string is valid if:
///
/// Open brackets must be closed by the same type of brackets.
/// Open brackets must be closed in the correct order.
/// Note that an empty string is also considered valid.

import XCTest

/// Approach: Stack
func isValid(_ s: String) -> Bool {
    var stack: [Character] = []
    for bracket in s {
        switch bracket {
        case "(":
            stack.append(")")
        case "{":
            stack.append("}")
        case "[":
            stack.append("]")
        default:
            guard bracket == stack.popLast() else { return false }
        }
    }
    return stack.isEmpty
}

class Tests: XCTestCase {
    func testExample() {
        let s = "()[]{}"
        XCTAssertTrue(isValid(s))
    }
}

Tests.defaultTestSuite.run()
