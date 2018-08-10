/// 15. 3Sum
/// Given an array nums of n integers, are there elements a, b, c in nums such that a + b + c = 0?
/// Find all unique triplets in the array which gives the sum of zero.
///
/// - Note: The solution set must not contain duplicate triplets.

import XCTest

// Approach: Two Pointers
func threeSum(_ nums: [Int]) -> [[Int]] {
    // [Int] is not Hashable in LeetCode runtime (Requires Swift 4.2).
    // This is a workaround. The Swift 4.2 solution is attached below.
    guard nums.count > 2 else { return [] }
    
    struct Three: Hashable {
        let x: Int
        let y: Int
        let z: Int
        
        init(_ x: Int, _ y: Int, _ z: Int) {
            self.x = x
            self.y = y
            self.z = z
        }
        
        func toArray() -> [Int] {
            return [x, y, z]
        }
    }
    let nums = nums.sorted()
    var set: Set<Three> = []
    for i in 0...nums.count - 3 {
        var head = i + 1
        var tail = nums.count - 1
        while head < tail {
            let sum = nums[i] + nums[head] + nums[tail]
            if sum == 0 {
                set.insert(Three(nums[i], nums[head], nums[tail]))
                head += 1
                tail -= 1
            } else if sum > 0 {
                tail -= 1
            } else {
                head += 1
            }
        }
    }
    return Array(set).map { $0.toArray() }
}

class Tests: XCTestCase {
    func testExample() {
        let nums = [-1, 0, 1, 2, -1, -4]
        let expected = [
            [-1, 0, 1],
            [-1, -1, 2],
        ]
        let solutions = threeSum(nums)
        XCTAssertEqual(solutions.count, expected.count)
        XCTAssertEqual(Set(solutions), Set(expected))
    }
}

Tests.defaultTestSuite.run()

func threeSum4_2(_ nums: [Int]) -> [[Int]] {
    let nums = nums.sorted()
    var set: Set<[Int]> = []
    for i in 0...nums.count - 3 {
        var head = i + 1
        var tail = nums.count - 1
        while head < tail {
            let sum = nums[i] + nums[head] + nums[tail]
            if sum == 0 {
                set.insert([nums[i], nums[head], nums[tail]])
                head += 1
                tail -= 1
            } else if sum > 0 {
                tail -= 1
            } else {
                head += 1
            }
        }
    }
    return Array(set)
}
