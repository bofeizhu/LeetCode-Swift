/// 22. Generate Parentheses
/// Given n pairs of parentheses, write a function to generate all combinations of well-formed
/// parentheses.
///
/// For example, given n = 3, a solution set is:
/// [
///  "((()))",
///  "(()())",
///  "(())()",
///  "()(())",
///  "()()()"
/// ]

import XCTest

// Approach: Backtracking
func generateParenthesis(_ n: Int) -> [String] {
    var combinations: [String] = []
    
    /// Backtracking to generate
    ///
    /// - Parameters:
    ///   - current: Current formation of parentheses
    ///   - open: Count of open brackets
    ///   - close: Count of close brackets
    func backtrack(
        current: String,
        open: Int,
        close: Int) {
        guard current.count < n * 2 else {
            combinations.append(current)
            return
        }
        
        if open < n {
            backtrack(current: current + "(", open: open + 1, close: close)
        }
        
        if close < open {
            backtrack(current: current + ")", open: open, close: close + 1)
        }
        
    }
    backtrack(current: "", open: 0, close: 0)
    return combinations
}

class Tests: XCTestCase {
    func testExample() {
    }
}

Tests.defaultTestSuite.run()
