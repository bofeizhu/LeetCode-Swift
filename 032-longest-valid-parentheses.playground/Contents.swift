/// 32. Longest Valid Parentheses
/// Given a string containing just the characters '(' and ')', find the length of the longest valid
/// (well-formed) parentheses substring.

import XCTest

/// Approach: Stack
func longestValidParentheses(_ s: String) -> Int {
    var stack = [-1]
    var longest = 0
    for (idx, p) in s.enumerated() {
        if p == "(" {
            stack.append(idx)
        } else {
            stack.popLast()
            if let last = stack.last {
                longest = max(longest, idx - last)
            } else {
                stack.append(idx)
            }
        }
        
    }
    return longest
}

class Tests: XCTestCase {
    func testExample() {
        XCTAssertEqual(longestValidParentheses("(()"), 2)
    }
}

Tests.defaultTestSuite.run()
