/// 17. Letter Combinations of a Phone Number
/// Given a string containing digits from 2-9 inclusive, return all possible letter combinations
/// that the number could represent.
///
/// A mapping of digit to letters (just like on the telephone buttons) is given below. Note that 1
/// does not map to any letters.

import XCTest

/// Approach: Backtracking
func letterCombinations(_ digits: String) -> [String] {
    let dict: [Character: [Character]] = [
        "2": Array("abc"),
        "3": Array("def"),
        "4": Array("ghi"),
        "5": Array("jkl"),
        "6": Array("mno"),
        "7": Array("pqrs"),
        "8": Array("tuv"),
        "9": Array("wxyz"),
    ]
    let digits = Array(digits)
    var combinations: [String] = []
    for digit in digits {
        guard let letters = dict[digit] else { fatalError() }
        var temp: [String] = []
        temp.reserveCapacity(combinations.count * letters.count)
        if combinations.isEmpty {
            temp = letters.map { String($0) }
        }
        for combination in combinations {
            for letter in letters {
                temp.append(combination + String(letter))
            }
        }
        combinations = temp
    }
    return combinations
}

class Tests: XCTestCase {
    func testExample() {
        let digits = "23"
        let expected = ["ad", "ae", "af", "bd", "be", "bf", "cd", "ce", "cf"]
        XCTAssertEqual(letterCombinations(digits), expected)
    }
}

Tests.defaultTestSuite.run()
