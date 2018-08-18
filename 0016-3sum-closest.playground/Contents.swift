/// 16. 3Sum Closest
/// Given an array nums of n integers and an integer target, find three integers in nums such that
/// the sum is closest to target. Return the sum of the three integers. You may assume that each
/// input would have exactly one solution.

import XCTest

// Approach: Two Pointers
func threeSumClosest(_ nums: [Int], _ target: Int) -> Int {
    guard nums.count > 2 else { fatalError() }
    let nums = nums.sorted()
    var closestSum = nums[0] + nums[1] + nums[2]
    for i in 0...nums.count - 3 {
        var head = i + 1
        var tail = nums.count - 1
        while head < tail {
            let sum = nums[i] + nums[head] + nums[tail]
            
            // update pointers
            if sum == target {
                return target
            } else if sum > target {
                tail -= 1
            } else {
                head += 1
            }
            
            // update closest sum
            closestSum = abs(sum - target) < abs(closestSum - target) ? sum : closestSum
        }
    }
    return closestSum
}

class Tests: XCTestCase {
    func testExample() {
        let nums = [-1, 2, 1, -4]
        XCTAssertEqual(threeSumClosest(nums, 1), 2)
    }
}

Tests.defaultTestSuite.run()
