/// 5. Longest Palindromic Substring
/// Given a string s, find the longest palindromic substring in s. You may assume that the maximum
/// length of s is 1000.

import XCTest

/// Approach: Manacher’s algorithm
func longestPalindrome(_ s: String) -> String {
    guard !s.isEmpty else { return "" }
    
    let count = s.count * 2 + 1
    var t: [Character] = ["#"]
    t.reserveCapacity(count)
    for c in s {
        t.append(c)
        t.append("#")
    }
    var p = Array(repeating: 0, count: count)
    var center = 0
    var rightEnd = 0
    for i in 1..<count - 1 {
        let mirror = 2 * center - i
        p[i] = rightEnd > i ? min(rightEnd - i, p[mirror]) : 0
        
        // Attempt to expand palindrome centered at i
        var left = i - 1 - p[i]
        var right = i + 1 + p[i]
        while left >= 0 && right < count && t[left] == t[right] {
            p[i] += 1
            left -= 1
            right += 1
        }
        
        // If palindrome centered at i expand past right end,
        // adjust center based on expanded palindrome.
        if i + p[i] > rightEnd {
            center = i
            rightEnd = i + p[i]
        }
    }
    
    var maxLen = 0
    var maxCenter = 0
    for i in 1..<count - 1 {
        if p[i] > maxLen {
            maxLen = p[i]
            maxCenter = i
        }
    }
    
    // maxCenter + 1 to offset even-length substring
    let start = s.index(s.startIndex, offsetBy: (maxCenter + 1 - maxLen) / 2)
    let end = s.index(start, offsetBy: maxLen)
    return String(s[start..<end])
}

class Tests: XCTestCase {
    func testExample1() {
        let s = "babad"
        XCTAssertEqual(longestPalindrome(s), "bab")
    }

    func testExample2() {
        let s = "cbbd"
        XCTAssertEqual(longestPalindrome(s), "bb")
    }
    
    func testExample3() {
        let s = "bb"
        XCTAssertEqual(longestPalindrome(s), "bb")
    }
}

Tests.defaultTestSuite.run()
