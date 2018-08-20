/// 298. Binary Tree Longest Consecutive Sequence
/// Given a binary tree, find the length of the longest consecutive sequence path. The path refers
/// to any sequence of nodes from some starting node to any node in the tree along the parent-child
/// connections. The longest consecutive path need to be from parent to child (cannot be the
/// reverse).

import XCTest

final class TreeNode {
    var val: Int
    var left: TreeNode?
    var right: TreeNode?
    init(_ val: Int) {
        self.val = val
        self.left = nil
        self.right = nil
    }
}

/// Approach: DFS
func longestConsecutive(_ root: TreeNode?) -> Int {
    var maxLength = 0
    func dfs(_ node: TreeNode?) -> Int {
        if let node = node {
            var leftLength = dfs(node.left) + 1
            var rightLength = dfs(node.right) + 1
            if let left = node.left,
               node.val + 1 != left.val {
                leftLength = 1
            }
            
            if let right = node.right,
               node.val + 1 != right.val {
                rightLength = 1
            }
            let length = max(leftLength, rightLength)
            maxLength = max(length, maxLength)
            return length
        } else {
            return 0
        }
    }
    dfs(root)
    return maxLength
}

class Tests: XCTestCase {
    func testExample() {
        // TODO: Add test case
    }
}

Tests.defaultTestSuite.run()
