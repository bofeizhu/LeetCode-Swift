/// 259. 3Sum Smaller
/// Given an array of n integers nums and a target, find the number of index triplets i, j, k
/// with 0 <= i < j < k < n that satisfy the condition nums[i] + nums[j] + nums[k] < target.

import XCTest

/// Approach: Two Pointers
func threeSumSmaller(_ nums: [Int], _ target: Int) -> Int {
    guard nums.count > 2 else { return 0 }
    let nums = nums.sorted()
    var count = 0
    for i in 0..<nums.count - 2 {
        var j = i + 1
        var k = nums.count - 1
        while j < k {
            if nums[i] + nums[j] + nums[k] < target {
                count += k - j
                j += 1
            } else {
                k -= 1
            }
        }
    }
    return count
}

class Tests: XCTestCase {
    func testExample() {
        let nums = [-2, 0, 1, 3]
        XCTAssertEqual(threeSumSmaller(nums, 2), 2)
    }
}

Tests.defaultTestSuite.run()
