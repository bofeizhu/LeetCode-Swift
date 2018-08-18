/// 1. Two Sum
/// Given an array of integers, return indices of the two numbers such that they add up to a
/// specific target.
///
/// You may assume that each input would have exactly one solution, and you may not use the same
/// element twice.

import XCTest

/// Approach: Dictionary
func twoSum(_ nums: [Int], _ target: Int) -> [Int] {
    var dict: [Int: Int] = [:]
    for (idx, num) in nums.enumerated() {
        let complement = target - num
        if let complementIdx = dict[complement] {
            return [idx, complementIdx]
        }
        dict[num] = idx
    }
    
    // each input would have exactly one solution
    fatalError()
}

class Tests: XCTestCase {
    func testExample() {
        let nums = [2, 7, 11, 15]
        let target = 9
        let solution = twoSum(nums, target)
        XCTAssertEqual(solution, [1, 0])
    }
    
    func testNotUseSameElement() {
        let nums = [3, 2, 4]
        let target = 6
        let solution = twoSum(nums, target)
        XCTAssertEqual(solution, [2, 1])
    }
    
    func testNumsHasSameElements() {
        let nums = [2, 2, 4]
        let target = 4
        let solution = twoSum(nums, target)
        XCTAssertEqual(solution, [1, 0])
    }
}

Tests.defaultTestSuite.run()
