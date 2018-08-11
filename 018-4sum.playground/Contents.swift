/// 18. 4Sum
/// Given an array nums of n integers and an integer target, are there elements a, b, c, and d in
/// nums such that a + b + c + d = target? Find all unique quadruplets in the array which gives the
/// sum of target.
///
/// - Note: The solution set must not contain duplicate quadruplets.

import XCTest

// Approach: Two Pointers
func fourSum(_ nums: [Int], _ target: Int) -> [[Int]] {
    // [Int] is not Hashable in LeetCode runtime (Requires Swift 4.2).
    // This is a workaround. The Swift 4.2 solution is attached below.
    guard nums.count > 3 else { return [] }
    
    struct Four: Hashable {
        let a: Int
        let b: Int
        let c: Int
        let d: Int
        
        init(_ a: Int, _ b: Int, _ c: Int, _ d: Int) {
            self.a = a
            self.b = b
            self.c = c
            self.d = d
        }
        
        func toArray() -> [Int] {
            return [a, b, c, d]
        }
    }
    let nums = nums.sorted()
    var set: Set<Four> = []
    for i in 0...nums.count - 4 {
        for j in i+1...nums.count - 3 {
            var head = j + 1
            var tail = nums.count - 1
            while head < tail {
                let sum = nums[i] + nums[j] + nums[head] + nums[tail]
                if sum == target {
                    set.insert(Four(nums[i], nums[j], nums[head], nums[tail]))
                    head += 1
                    tail -= 1
                } else if sum > target {
                    tail -= 1
                } else {
                    head += 1
                }
            }
        }
    }
    return Array(set).map { $0.toArray() }
}

func fourSum4_2(_ nums: [Int], _ target: Int) -> [[Int]] {
    let nums = nums.sorted()
    var set: Set<[Int]> = []
    for i in 0...nums.count - 3 {
        for j in i+1...nums.count - 3 {
            var head = j + 1
            var tail = nums.count - 1
            while head < tail {
                let sum = nums[i] + nums[j] + nums[head] + nums[tail]
                if sum == target {
                    set.insert([nums[i], nums[j], nums[head], nums[tail]])
                    head += 1
                    tail -= 1
                } else if sum > target {
                    tail -= 1
                } else {
                    head += 1
                }
            }
        }
    }
    return Array(set)
}

class Tests: XCTestCase {
    func testExample() {
        let nums = [1, 0, -1, 0, -2, 2]
        let expected = [
            [-1,  0, 0, 1],
            [-2, -1, 1, 2],
            [-2,  0, 0, 2],
        ]
        let solutions = fourSum(nums, 0)
        XCTAssertEqual(solutions.count, expected.count)
        XCTAssertEqual(Set(solutions), Set(expected))
    }
}

Tests.defaultTestSuite.run()
