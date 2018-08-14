/// 31. Next Permutation
/// Implement next permutation, which rearranges numbers into the lexicographically next greater
/// permutation of numbers.
/// If such arrangement is not possible, it must rearrange it as the lowest possible order (ie,
/// sorted in ascending order).
/// The replacement must be in-place and use only constant extra memory.

import XCTest

// Approach: Swap and Reverse
func nextPermutation(_ nums: inout [Int]) {
    func reverse(from start: Int) {
        var start = start
        var end = nums.count - 1
        while start < end {
            nums.swapAt(start, end)
            start += 1
            end -= 1
        }
    }
    
    var i = nums.count - 2 // index of first descending number
    while i >= 0 && nums[i] >= nums[i + 1] {
        i -= 1
    }
    
    if i >= 0 {
        var j = nums.count - 1 // index of the number just larger than nums[i]
        while j > i && nums[j] <= nums[i] {
            j -= 1
        }
        nums.swapAt(i, j);
    }
    reverse(from: i + 1)
}

class Tests: XCTestCase {
    func testExample1() {
        var nums = [1, 2, 3]
        nextPermutation(&nums)
        XCTAssertEqual(nums, [1, 3, 2])
    }
    
    func testExample2() {
        var nums = [1, 2]
        nextPermutation(&nums)
        XCTAssertEqual(nums, [2, 1])
    }
}

Tests.defaultTestSuite.run()
