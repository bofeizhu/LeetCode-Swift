/// 766. Toeplitz Matrix
/// A matrix is Toeplitz if every diagonal from top-left to bottom-right has the same element. Now
/// given an M x N matrix, return True if and only if the matrix is Toeplitz.

import XCTest

func isToeplitzMatrix(_ matrix: [[Int]]) -> Bool {
    let n = matrix.count
    guard n > 0 else { return true }
    let m = matrix[0].count
    for i in 1..<n {
        for j in 1..<m {
            if matrix[i][j] != matrix[i - 1][j - 1] {
                return false
            }
        }
    }
    return true
}

class Tests: XCTestCase {
    func testExample() {
        let matrix = [
            [1, 2, 3, 4],
            [5, 1, 2, 3],
            [9, 5, 1, 2],
        ]
        XCTAssertTrue(isToeplitzMatrix(matrix))
    }
}

Tests.defaultTestSuite.run()
