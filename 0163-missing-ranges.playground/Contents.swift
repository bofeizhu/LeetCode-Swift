/// 163. Missing Ranges
/// Given a sorted integer array nums, where the range of elements are in the inclusive range
/// [lower, upper], return its missing ranges.
///
/// Example:
/// Input: nums = [0, 1, 3, 50, 75], lower = 0 and upper = 99,
/// Output: ["2", "4->49", "51->74", "76->99"]

import XCTest

/// Approach: Iteration
func findMissingRanges(_ nums: [Int], _ lower: Int, _ upper: Int) -> [String] {
    var numbers = [lower - 1]
    numbers.append(contentsOf: nums)
    numbers.append(upper + 1)
    var result: [String] = []
    for i in 0..<numbers.count - 1 {
        let difference = numbers[i + 1] - numbers[i]
        guard difference > 1 else { continue }
        if difference == 2 {
            result.append(String(numbers[i] + 1))
        } else {
            result.append(String(numbers[i] + 1) + "->" + String(numbers[i + 1] - 1))
        }
    }
    return result
}

class Tests: XCTestCase {
    func testExample() {
        let nums = [0, 1, 3, 50, 75]
        let expected = ["2", "4->49", "51->74", "76->99"]
        XCTAssertEqual(findMissingRanges(nums, 0, 99), expected)
    }
}

Tests.defaultTestSuite.run()
