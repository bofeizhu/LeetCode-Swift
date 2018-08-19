/// 482. License Key Formatting
/// You are given a license key represented as a string S which consists only alphanumeric
/// character and dashes. The string is separated into N+1 groups by N dashes.
/// Given a number K, we would want to reformat the strings such that each group contains exactly
/// K characters, except for the first group which could be shorter than K, but still must contain
/// at least one character. Furthermore, there must be a dash inserted between two groups and all
/// lowercase letters should be converted to uppercase.
/// Given a non-empty string S and a number K, format the string according to the rules
/// described above.

import XCTest

/// Approach: String
func licenseKeyFormatting(_ s: String, _ k: Int) -> String {
    var s = Array(s.uppercased())
    var result: [Character] = []
    for i in stride(from: s.count - 1, through: 0, by: -1) {
        guard s[i] != "-" else { continue }
        if result.count % (k + 1) == k {
            result.append("-")
        }
        result.append(s[i])
    }
    return String(result.reversed())
}


class Tests: XCTestCase {
    func testExample() {
        let s = "5F3Z-2e-9-w"
        let k = 4
        XCTAssertEqual(licenseKeyFormatting(s, k), "5F3Z-2E9W")
    }
}

Tests.defaultTestSuite.run()
