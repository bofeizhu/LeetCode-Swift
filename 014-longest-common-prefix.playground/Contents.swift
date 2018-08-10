/// 14. Longest Common Prefix
/// Write a function to find the longest common prefix string amongst an array of strings.
/// If there is no common prefix, return an empty string "".

import XCTest

func longestCommonPrefix(_ strs: [String]) -> String {
    guard !strs.isEmpty else { return "" }
    let strs = strs.map { Array($0) }
    for i in 0..<strs[0].count {
        let char = strs[0][i]
        for j in 1..<strs.count {
            if i == strs[j].count || strs[j][i] != char {
                return String(strs[0][0..<i])
            }
        }
    }
    return String(strs[0])
}

class Tests: XCTestCase {
    func testExample() {
        let strs = ["flower", "flow", "flight"]
        XCTAssertEqual(longestCommonPrefix(strs), "fl")
    }
}

Tests.defaultTestSuite.run()
