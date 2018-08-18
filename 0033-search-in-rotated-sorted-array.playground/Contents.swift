/// 33. Search in Rotated Sorted Array
/// Suppose an array sorted in ascending order is rotated at some pivot unknown to you beforehand.
/// (i.e., [0,1,2,4,5,6,7] might become [4,5,6,7,0,1,2]).
/// You are given a target value to search. If found in the array return its index,
/// otherwise return -1.
/// You may assume no duplicate exists in the array.
/// Your algorithm's runtime complexity must be in the order of O(log n).

import XCTest

/// Approach: Binary Search
func search(_ nums: [Int], _ target: Int) -> Int {
    guard !nums.isEmpty else { return -1 }
    var left = 0
    var right = nums.count - 1
    while left <= right {
        let mid = (left + right) / 2
        guard nums[mid] != target else { return mid }
        if nums[left] <= nums[mid] {
            if nums[left] <= target && nums[mid] >= target {
                right = mid - 1
            } else {
                left = mid + 1
            }
        } else {
            if nums[mid] <= target && nums[right] >= target {
                left = mid + 1
            } else {
                right = mid - 1
            }
        }
    }
    return -1
}

class Tests: XCTestCase {
    func testExample() {
        let nums = [4,5,6,7,0,1,2]
        XCTAssertEqual(search(nums, 0), 4)
    }
}

Tests.defaultTestSuite.run()
