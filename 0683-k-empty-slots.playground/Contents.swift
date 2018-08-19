/// 683. K Empty Slots
/// There is a garden with N slots. In each slot, there is a flower. The N flowers will bloom one by
/// one in N days. In each day, there will be exactly one flower blooming and it will be in the
/// status of blooming since then.
/// Given an array flowers consists of number from 1 to N. Each number in the array represents the
/// place where the flower will open in that day.
///
/// For example, flowers[i] = x means that the unique flower that blooms at day i will be at
/// position x, where i and x will be in the range from 1 to N. Also given an integer k, you need to
/// output in which day there exists two flowers in the status of blooming, and also the number of
/// flowers between them is k and these flowers are not blooming.
/// If there isn't such day, output -1.

import XCTest

/// Approach: Sliding Window
func kEmptySlots(_ flowers: [Int], _ k: Int) -> Int {
    // number of days
    let n = flowers.count
    guard n > 1 else { return -1 }
    // flowers at position x blooms at day datas[x]
    var days: [Int] = Array(repeating: -1, count: n)
    for (i, x) in flowers.enumerated() {
        days[x - 1] = i + 1
    }
    var left = 0
    var right = k + 1
    var minDate = Int.max
    while right < n {
        var hasKEmpty = true
        for i in left + 1..<right {
            if days[i] < days[left] || days[i] < days[right] {
                left = i
                right = i + k + 1
                hasKEmpty = false
                break
            }
        }
        guard hasKEmpty else { continue }
        minDate = min(minDate, max(days[left], days[right]))
        left = right
        right = left + k + 1
    }
    return minDate < Int.max ? minDate : -1
}

class Tests: XCTestCase {
    func testExample() {
        let flowers = [1, 3, 2]
        XCTAssertEqual(kEmptySlots(flowers, 1), 2)
    }
}

Tests.defaultTestSuite.run()
