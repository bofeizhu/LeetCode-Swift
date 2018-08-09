/// 1. Two Sum
/// Given an array of integers, return indices of the two numbers such that they add up to a
/// specific target.
///
/// You may assume that each input would have exactly one solution, and you may not use the same
/// element twice.

import XCTest

/// Approach: Two-pass Dictionary
func twoSum(_ nums: [Int], for target: Int) -> [Int] {
    // 1st pass build a dictionary for number -> index
    var dict: [Int: Int] = [:]
    for (idx, num) in nums.enumerated() {
        dict[num] = idx
    }
    
    // 2nd pass
    for (idx, num) in nums.enumerated() {
        let complement = target - num
        guard let complementIdx = dict[complement],
              idx != complementIdx
        else { continue }
        return [idx, complementIdx]
    }
    
    // each input would have exactly one solution
    fatalError()
}

class Tests: XCTestCase {
    func testExample() {
        let nums = [2, 7, 11, 15]
        let target = 9
        let solution = twoSum(nums, for: target)
        XCTAssertEqual(solution, [0, 1])
    }
    
    func testNotUseSameElement() {
        let nums = [3, 2, 4]
        let target = 6
        let solution = twoSum(nums, for: target)
        XCTAssertEqual(solution, [1, 2])
    }
}

Tests.defaultTestSuite.run()
