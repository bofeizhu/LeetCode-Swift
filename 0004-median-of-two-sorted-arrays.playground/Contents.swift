/// 4. Median of Two Sorted Arrays
/// There are two sorted arrays nums1 and nums2 of size m and n respectively. Find the median of the
/// two sorted arrays. The overall run time complexity should be O(log (m+n)).
/// You may assume nums1 and nums2 cannot be both empty.
import XCTest

/// Approach: Recursive & Binary search
func findMedianSortedArrays(_ nums1: [Int], _ nums2: [Int]) -> Double {
    var short: [Int] = []
    var long: [Int] = []
    
    if nums1.count < nums2.count {
        // copy-on-write O(1)
        short = nums1
        long = nums2
    } else {
        short = nums2
        long = nums1
    }
    
    var minIdx = 0
    var maxIdx = short.count
    let halfLen = (short.count + long.count + 1) / 2
    
    while minIdx <= maxIdx {
        let i = (minIdx + maxIdx) / 2
        let j = halfLen - i
        
        if i < maxIdx && long[j - 1] > short[i] {
            // i is too small
            minIdx = i + 1
        } else if i > minIdx && short[i - 1] > long[j] {
            // i is too big
            maxIdx = i - 1
        } else {
            // i is perfect
            var maxLeft = 0
            if i == 0 {
                maxLeft = long[j - 1]
            } else if j == 0 {
                maxLeft = short[i - 1]
            } else {
                maxLeft = max(short[i - 1], long[j - 1])
            }
            
            if (short.count + long.count) % 2 == 1 {
                return Double(maxLeft)
            }
            
            var minRight = 0
            if i == short.count {
                minRight = long[j]
            } else if j == long.count {
                minRight = short[i]
            } else {
                minRight = min(short[i], long[j])
            }
            
            return Double(maxLeft + minRight) / 2.0
        }
    }
    
    fatalError()
}

class Tests: XCTestCase {
    func testExample1() {
        let nums1 = [1, 3]
        let nums2 = [2]
        XCTAssertEqual(findMedianSortedArrays(nums1, nums2), 2.0)
    }
    
    func testExample2() {
        let nums1 = [1, 2, 3]
        let nums2 = [4, 5, 6]
        XCTAssertEqual(findMedianSortedArrays(nums1, nums2), 3.5)
    }

    func testExample3() {
        let nums1 = [2]
        let nums2: [Int] = []
        XCTAssertEqual(findMedianSortedArrays(nums1, nums2), 2.0)
    }
    
    func testExample4() {
        let nums1: [Int] = []
        let nums2 = [1]
        XCTAssertEqual(findMedianSortedArrays(nums1, nums2), 1.0)
    }
    
    func testExample5() {
        let nums1 = [3]
        let nums2 = [-2, -1]
        XCTAssertEqual(findMedianSortedArrays(nums1, nums2), -1.0)
    }
    
    func testExample6() {
        let nums1 = [2]
        let nums2 = [1, 3, 4]
        XCTAssertEqual(findMedianSortedArrays(nums1, nums2), 2.5)
    }
}

Tests.defaultTestSuite.run()
