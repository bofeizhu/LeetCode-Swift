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
    var result: [String] = []
    for i in -1..<nums.count {
        let current = i == -1 ? lower - 1 : nums[i]
        let next = i + 1 < nums.count ? nums[i + 1] : upper + 1
        let difference = next - current
        guard difference > 1 else { continue }
        if difference == 2 {
            result.append(String(current + 1))
        } else {
            result.append(String(current + 1) + "->" + String(next - 1))
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
