/// 686. Repeated String Match
/// Given two strings A and B, find the minimum number of times A has to be repeated such that B is
/// a substring of it. If no such solution, return -1. For example, with A = "abcd" and
/// B = "cdabcdab". Return 3, because by repeating A three times (“abcdabcdabcd”), B is a substring
/// of it; and B is not a substring of A repeated two times ("abcdabcd").

import XCTest

/// Approach: Dictionary
func repeatedStringMatch(_ a: String, _ b: String) -> Int {
    guard a.range(of: b) == nil else { return 1 }
    let repeated = a
    var a = a
    var count = 1
    let bCount = b.count
    let repeatedCount = repeated.count
    while count == 1 || repeatedCount * count <= bCount + repeatedCount {
        a += repeated
        count += 1
        guard repeatedCount * count >= bCount else { continue }
        if a.range(of: b) != nil {
            return count
        }
    }
    return -1
}

class Tests: XCTestCase {
    func testExample() {
        let a = "abcd"
        let b = "cdabcdab"
        XCTAssertEqual(repeatedStringMatch(a, b), 3)
    }
}

Tests.defaultTestSuite.run()
