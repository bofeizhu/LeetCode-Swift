/// 10. Regular Expression Matching
/// Given an input string (s) and a pattern (p), implement regular expression matching with support
/// for '.' and '*'.
///
/// '.' Matches any single character.
/// '*' Matches zero or more of the preceding element.
/// The matching should cover the entire input string (not partial).

import XCTest

/// Approach: Dynamic Programming
func isMatch(_ s: String, _ p: String) -> Bool {
    guard !p.isEmpty else {
        guard s.isEmpty else {
            return false
        }
        return true
    }
    
    let s = Array(s)
    let p = Array(p)
    
    // matchMatrix[i][j] first i chars in s match p[0...j]
    var match = Array(repeating: Array(repeating: false, count: p.count), count: s.count + 1)
    
    // init for i = 0
    for j in 1..<p.count {
        if p[j] == "*" {
            match[0][j] = j > 1 ? match[0][j-2] : true
        }
    }
    
    guard !s.isEmpty else { return match[0][p.count - 1] }
    for i in 1...s.count {
        if i == 1 {
            match[1][0] = p[0] == "." ? true : s[0] == p[0]
        }
        for j in 1..<p.count {
            switch p[j] {
            case ".":
                match[i][j] = match[i - 1][j - 1]
            case "*":
                if p[j - 1] == "." || s[i - 1] == p[j - 1] { // match preceding element
                    match[i][j] = match[i - 1][j] || match[i - 1][j - 1]
                }
                
                guard !match[i][j] else { continue }
                if j > 1 { // match zero element
                    match[i][j] = match[i][j - 2]
                }
            case s[i - 1]:
                match[i][j] = match[i - 1][j - 1]
            default:
                continue
            }
        }
    }
    return match[s.count][p.count - 1]
}

class Tests: XCTestCase {
    func testExample1() {
        let s = "aa"
        let p = "a"
        XCTAssertFalse(isMatch(s, p))
    }

    func testExample2() {
        let s = "aa"
        let p = "a*"
        XCTAssertTrue(isMatch(s, p))
    }

    func testExample3() {
        let s = "ab"
        let p = ".*"
        XCTAssertTrue(isMatch(s, p))
    }

    func testExample4() {
        let s = "aab"
        let p = "c*a*b"
        XCTAssertTrue(isMatch(s, p))
    }

    func testExample5() {
        let s = "mississippi"
        let p = "mis*is*p*."
        XCTAssertFalse(isMatch(s, p))
    }

    func testExample6() {
        let s = ""
        let p = ".*"
        XCTAssertTrue(isMatch(s, p))
    }
    
    func testExample7() {
        let s = "aaa"
        let p = "ab*ac*a"
        XCTAssertTrue(isMatch(s, p))
    }
    
    func testExample8() {
        let s = "aaca"
        let p = "ab*a*c*a"
        XCTAssertTrue(isMatch(s, p))
    }
    
    func testExample9() {
        let s = "a"
        let p = "ab*a"
        XCTAssertFalse(isMatch(s, p))
    }
}

Tests.defaultTestSuite.run()
