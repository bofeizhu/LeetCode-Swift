/// 11. Container With Most Water
/// Given n non-negative integers a1, a2, ..., an , where each represents a point at coordinate
/// (i, ai). n vertical lines are drawn such that the two endpoints of line i is at (i, ai) and
/// (i, 0). Find two lines, which together with x-axis forms a container, such that the container
/// contains the most water.
///
/// - Note: You may not slant the container and n is at least 2.

import XCTest

/// Approach: Two Pointers
/// Move shorter line inwards
func maxArea(_ height: [Int]) -> Int {
    var maxArea = 0
    var left = 0
    var right = height.count - 1
    while left < right {
        let area = (right - left) * min(height[left], height[right])
        maxArea = max(area, maxArea)
        if height[left] > height[right] {
            right -= 1
        } else {
            left += 1
        }
    }
    return maxArea
}

class Tests: XCTestCase {
    func testExample1() {
        let height = [1, 8, 6, 2, 5, 4, 8, 3, 7]
        XCTAssertEqual(maxArea(height), 49)
    }
}

Tests.defaultTestSuite.run()
