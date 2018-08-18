/// 28. Implement strStr()
/// Return the index of the first occurrence of needle in haystack, or -1 if needle is not part of
/// haystack.

import XCTest

func strStr(_ haystack: String, _ needle: String) -> Int {
    guard !needle.isEmpty else { return 0 }
    guard let range = haystack.range(of: needle) else { return -1 }
    return range.lowerBound.encodedOffset
}

class Tests: XCTestCase {
    func testExample() {
        let haystack = "hello"
        let needle = "ll"
        XCTAssertEqual(strStr(haystack, needle), 2)
    }
}

Tests.defaultTestSuite.run()
