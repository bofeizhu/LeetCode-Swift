/// 280. Wiggle Sort
/// Given an unsorted array nums, reorder it in-place such that
/// nums[0] <= nums[1] >= nums[2] <= nums[3]....

import XCTest

/// Approach: Swap
func wiggleSort(_ nums: inout [Int]) {
    guard nums.count > 1 else { return }
    for i in 0..<nums.count - 1 {
        if (i % 2 == 0 && nums[i] > nums[i + 1]) ||
           (i % 2 != 0 && nums[i] < nums[i + 1]) {
            nums.swapAt(i, i + 1)
        }
    }
}

class Tests: XCTestCase {
    func testExample() {
        var nums = [3, 5, 2, 1, 6, 4]
        let expected = [3, 5, 1, 6, 2, 4]
        wiggleSort(&nums)
        XCTAssertEqual(nums, expected)
    }
}

Tests.defaultTestSuite.run()
