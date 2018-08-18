/// 26. Remove Duplicates from Sorted Array
/// Given a sorted array nums, remove the duplicates in-place such that each element appear only
/// once and return the new length.
///
/// Do not allocate extra space for another array, you must do this by modifying the input array
/// in-place with O(1) extra memory.

import XCTest

/// Approach: Two Pointers
func removeDuplicates(_ nums: inout [Int]) -> Int {
    guard nums.count > 1 else { return nums.count }
    var i = 0
    var j = 1
    while j < nums.count {
        if nums[j] > nums[i] {
            nums[i + 1] = nums[j]
            i += 1
        }
        j += 1
    }
    return i + 1
}

class Tests: XCTestCase {
    func testExample() {
        var nums = [0, 0, 1, 1, 1, 2, 2, 3, 3, 4]
        let expected = [0, 1, 2, 3, 4]
        XCTAssertEqual(removeDuplicates(&nums), 5)
        XCTAssertEqual(Array(nums.prefix(5)), expected)
    }
}

Tests.defaultTestSuite.run()
