/// 84. Largest Rectangle in Histogram
/// Given n non-negative integers representing the histogram's bar height where the width of each
/// bar is 1, find the area of largest rectangle in the histogram.

import XCTest

/// Approach: Stack
func largestRectangleArea(_ heights: [Int]) -> Int {
    var heights = heights
    heights.append(-1)
    
    var stack = [-1]
    var maxArea = 0
    
    for (idx, height) in heights.enumerated() {
        // pop stack until last height is smaller than current height
        while let last = stack.last, last >= 0 && heights[last] > height {
            stack.removeLast()
            if let left = stack.last {
                let area = (idx - left - 1) * heights[last]
                maxArea = max(area, maxArea)
            }
        }
        stack.append(idx)
    }
    return maxArea
}

class Tests: XCTestCase {
    func testExample() {
        let heights = [2, 1, 5, 6, 2, 3]
        XCTAssertEqual(largestRectangleArea(heights), 10)
    }
}

Tests.defaultTestSuite.run()
