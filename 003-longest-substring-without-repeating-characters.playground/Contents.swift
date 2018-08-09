/// 3. Longest Substring Without Repeating Characters
/// Given a string, find the length of the longest substring without repeating characters.

import XCTest

/// Approach: Sliding Window with Dictionary
func lengthOfLongestSubstring(_ s: String) -> Int {
    var dict: [Character: Int] = [:]
    var head = 0
    var length = 0
    for (tail, char) in s.enumerated() {
        if let previousIdx = dict[char] {
            head = max(previousIdx + 1, head)
        }
        length = max(length, tail - head + 1)
        dict[char] = tail
    }
    return length
}

class Tests: XCTestCase {
    func testExample() {
        let s = "abcabcbb"
        let length = lengthOfLongestSubstring(s)
        XCTAssertEqual(length, 3)
    }
}

Tests.defaultTestSuite.run()
