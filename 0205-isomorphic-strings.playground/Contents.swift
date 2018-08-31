/// 205. Isomorphic Strings
/// Given two strings s and t, determine if they are isomorphic. Two strings are isomorphic if the
/// characters in s can be replaced to get t. All occurrences of a character must be replaced with
/// another character while preserving the order of characters. No two characters may map to the
/// same character but a character may map to itself.

import XCTest

func isIsomorphic(_ s: String, _ t: String) -> Bool {
    let s = Array(s)
    let t = Array(t)
    guard s.count == t.count else { return false }
    
    var dict: [Character: Character] = [:]
    for i in 0..<s.count {
        if let map = dict[s[i]] {
            guard map == t[i] else { return false }
        } else if dict.values.contains(t[i]) {
            return false
        } else {
            dict[s[i]] = t[i]
        }
    }
    return true
}

class Tests: XCTestCase {
    func testExample() {
        let s = "add"
        let t = "egg"
        XCTAssertTrue(isIsomorphic(s, t))
    }
}

Tests.defaultTestSuite.run()
