/// 803. Bricks Falling When Hit
/// We have a grid of 1s and 0s; the 1s in a cell represent bricks. A brick will not drop if and
/// only if it is directly connected to the top of the grid, or at least one of its (4-way) adjacent
/// bricks will not drop.
/// We will do some erasures sequentially. Each time we want to do the erasure at the
/// location (i, j), the brick (if it exists) on that location will disappear, and then some other
/// bricks may drop because of that erasure.
/// Return an array representing the number of bricks that will drop after each erasure in sequence.

import XCTest

struct UnionFind<T: Hashable> {
    private var index: [T: Int] = [:]
    private var parent: [Int] = []
    private var size: [Int] = []
    
    mutating func addSetWith(_ element: T) {
        index[element] = parent.count
        parent.append(parent.count)
        size.append(1)
    }
    
    /// Path Compression.
    private mutating func setByIndex(_ index: Int) -> Int {
        if index != parent[index] {
            parent[index] = setByIndex(parent[index])
        }
        return parent[index]
    }
    
    mutating func setOf(_ element: T) -> Int? {
        guard let indexOfElement = index[element] else { return nil }
        return setByIndex(indexOfElement)
    }
    
    mutating func sizeOf(_ element: T) -> Int {
        guard let set = setOf(element) else { return 0 }
        return size[set]
    }
    
    mutating func unionSetsContaining(_ firstElement: T, and secondElement: T) {
        guard let firstSet = setOf(firstElement),
              let secondSet = setOf(secondElement),
              firstSet != secondSet
        else { return }
        if size[firstSet] < size[secondSet] {
            parent[firstSet] = secondSet
            size[secondSet] += size[firstSet]
        } else {
            parent[secondSet] = firstSet
            size[firstSet] += size[secondSet]
        }
    }
    
    mutating func inSameSet(_ firstElement: T, and secondElement: T) -> Bool {
        guard let firstSet = setOf(firstElement), let secondSet = setOf(secondElement)
        else { return false }
        return firstSet == secondSet
    }
}

/// Approach: Union Find
func hitBricks(_ grid: [[Int]], _ hits: [[Int]]) -> [Int] {
    
}

class Tests: XCTestCase {
    func testExample() {
    }
}

Tests.defaultTestSuite.run()
