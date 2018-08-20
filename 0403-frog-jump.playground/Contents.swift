/// 403. Frog Jump
/// A frog is crossing a river. The river is divided into x units and at each unit there may or may
/// not exist a stone. The frog can jump on a stone, but it must not jump into the water.
/// Given a list of stones' positions (in units) in sorted ascending order, determine if the frog is
/// able to cross the river by landing on the last stone. Initially, the frog is on the first stone
/// and assume the first jump must be 1 unit.
/// If the frog's last jump was k units, then its next jump must be either k - 1, k, or k + 1 units.
/// Note that the frog can only jump in the forward direction.
///
/// - Note:
///     The number of stones is ≥ 2 and is < 1,100.
///     Each stone's position will be a non-negative integer < 231.
///     The first stone's position is always 0.

import XCTest

/// Approach: Dynamic Programming
func canCross(_ stones: [Int]) -> Bool {
    // key: stone positions, value: Set of steps lead to stone
    var dict: [Int: Set<Int>] = [:]
    dict.reserveCapacity(stones.count)
    for i in 0..<stones.count {
        dict[stones[i]] = []
    }
    dict[stones[0]]!.insert(0)
    for i in 0..<stones.count {
        for k in dict[stones[i]]! {
            for step in k-1...k+1 {
                let next = stones[i] + step
                if step > 0 && dict.keys.contains(next) {
                    dict[next]!.insert(step)
                }
            }
        }
    }
    return dict[stones.last!]!.count > 0
}

class Tests: XCTestCase {
    func testExample() {
        let stones = [0, 1, 3, 5, 6, 8, 12, 17]
        XCTAssertTrue(canCross(stones))
    }
}

Tests.defaultTestSuite.run()
