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
    var dropped = grid
    let m = grid.count
    guard m > 0 else { return [] }
    let n = grid[0].count
    
    // remove all the hits
    for hit in hits {
        dropped[hit[0]][hit[1]] = 0
    }
    
    var dset = UnionFind<Int>()
    dset.addSetWith(Int.min) // roof set
    for r in 0..<m {
        for c in 0..<n {
            if dropped[r][c] == 1 {
                let index = r * n + c
                dset.addSetWith(index)
                if r == 0 {
                    dset.unionSetsContaining(index, and: Int.min)
                }
                if r > 0 && dropped[r - 1][c] == 1 {
                    dset.unionSetsContaining(index, and: (r - 1) * n + c)
                }
                if c > 0 && dropped[r][c - 1] == 1 {
                    dset.unionSetsContaining(index, and: r * n + c - 1)
                }
            }
        }
    }
    
    var result = Array(repeating: 0, count: hits.count)
    for i in stride(from: hits.count - 1, through: 0, by: -1) {
        let r = hits[i][0]
        let c = hits[i][1]
        let oldCount = dset.sizeOf(Int.min)
        guard grid[r][c] == 1 else { continue }
        let index = r * n + c
        dset.addSetWith(index)
        if r > 0 && dropped[r - 1][c] == 1 {
            dset.unionSetsContaining(index, and: (r - 1) * n + c)
        }
        if r + 1 < m && dropped[r + 1][c] == 1 {
            dset.unionSetsContaining(index, and: (r + 1) * n + c)
        }
        if c > 0 && dropped[r][c - 1] == 1 {
            dset.unionSetsContaining(index, and: r * n + c - 1)
        }
        if c + 1 < n && dropped[r][c + 1] == 1 {
            dset.unionSetsContaining(index, and: r * n + c + 1)
        }
        if r == 0 {
            dset.unionSetsContaining(index, and: Int.min)
        }
        dropped[r][c] = 1
        result[i] = max(0, dset.sizeOf(Int.min) - oldCount - 1)
    }
    return result
}

class Tests: XCTestCase {
    func testExample1() {
        let grid = [[1, 0, 0, 0], [1, 1, 1, 0]]
        let hits = [[1, 0]]
        XCTAssertEqual(hitBricks(grid, hits), [2])
    }
    
    func testExample2() {
        let grid = [[1], [1], [1], [1], [1]]
        let hits = [[3, 0], [4, 0], [1, 0], [2, 0], [0, 0]]
        XCTAssertEqual(hitBricks(grid, hits), [1, 0, 1, 0, 0])
    }
}

Tests.defaultTestSuite.run()
