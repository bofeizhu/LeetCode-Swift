/// 27. Remove Element
/// Given an array nums and a value val, remove all instances of that value in-place and return
/// the new length. Do not allocate extra space for another array, you must do this by modifying the
/// input array in-place with O(1) extra memory.
///
/// The order of elements can be changed. It doesn't matter what you leave beyond the new length.

import XCTest

/// Approach: Two Pointers
func removeElement(_ nums: inout [Int], _ val: Int) -> Int {
    guard !nums.isEmpty else { return 0 }
    var head = 0
    var tail = nums.count - 1
    while head <= tail {
        while nums[tail] == val {
            tail -= 1
            guard tail >= 0 else { return 0 }
        }
        
        guard head < tail else { break }
        if nums[head] == val {
            nums.swapAt(head, tail)
        }
        head += 1
    }
    return tail + 1
}

class Tests: XCTestCase {
    func testExample1() {
        var nums = [3, 2, 2, 3]
        let expected = [2, 2]
        XCTAssertEqual(removeElement(&nums, 3), 2)
        XCTAssertEqual(Array(nums.prefix(2)), expected)
    }
    
    func testExample2() {
        var nums = [1]
        XCTAssertEqual(removeElement(&nums, 1), 0)
    }
}

Tests.defaultTestSuite.run()
