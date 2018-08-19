/// 200. Number of Islands
/// Given a 2d grid map of '1's (land) and '0's (water), count the number of islands. An island is
/// surrounded by water and is formed by connecting adjacent lands horizontally or vertically. You
/// may assume all four edges of the grid are all surrounded by water.

import XCTest

/// Approach: BFS
func numIslands(_ grid: [[Character]]) -> Int {
    var grid = grid
    let m = grid.count
    guard m > 0 else { return 0}
    let n = grid[0].count
    var count = 0
    for i in 0..<m {
        for j in 0..<n {
            guard grid[i][j] == "1" else { continue }
            count += 1
            var queue: [Int] = []
            queue.append(i * n + j)
            grid[i][j] = "v"
            var head = 0
            while head < queue.count {
                let index = queue[head]
                head += 1
                let r = index / n
                let c = index % n
                if r > 0, grid[r - 1][c] == "1" {
                    queue.append((r - 1) * n + c)
                    grid[r - 1][c] = "v"
                }
                if c > 0, grid[r][c - 1] == "1" {
                    queue.append(r * n + c - 1)
                    grid[r][c - 1] = "v"
                }
                if r + 1 < m, grid[r + 1][c] == "1" {
                    queue.append((r + 1) * n + c)
                    grid[r + 1][c] = "v"
                }
                if c + 1 < n, grid[r][c + 1] == "1" {
                    queue.append(r * n + c + 1)
                    grid[r][c + 1] = "v"
                }
            }
        }
    }
    return count
}

class Tests: XCTestCase {
    func testExample() {
        let grid: [[Character]] = [
            ["1", "1", "1", "1", "0"],
            ["1", "1", "0", "1", "0"],
            ["1", "1", "0", "0", "0"],
            ["1", "0", "0", "0", "0"],
        ]
        XCTAssertEqual(numIslands(grid), 1)
    }
}

Tests.defaultTestSuite.run()
