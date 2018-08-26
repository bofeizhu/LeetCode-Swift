/// 159. Longest Substring with At Most Two Distinct Characters
/// Given a string s, find the length of the longest substring t  that contains at most 2 distinct
/// characters.

import XCTest

/// Approach: Two Pointers
func lengthOfLongestSubstringTwoDistinct(_ s: String) -> Int {
    let s = Array(s)
    guard s.count > 2 else { return s.count }
    var first = 0 // index of the lastest first character
    var second = 1 // index of the lastest second character
    var maxLength = 2
    var count = 2
    for i in 2..<s.count {
        count += 1
        if s[i] == s[first] {
            first = i
        } else if s[i] == s[second] {
            second = i
        } else if s[first] == s[second] {
            first = i
        } else {
            // update character and count
            count = second - first + 1
            first = second
            second = i
        }
        
        maxLength = maxLength > count ? maxLength : count
        
        if first > second {
            swap(&first, &second)
        }
    }
    return maxLength
}

class Tests: XCTestCase {
    func testExample() {
        let s = "ccaabbb"
        XCTAssertEqual(lengthOfLongestSubstringTwoDistinct(s), 5)
    }
}

Tests.defaultTestSuite.run()
