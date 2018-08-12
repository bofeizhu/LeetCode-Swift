/// 25. Reverse Nodes in k-Group
/// Given a linked list, reverse the nodes of a linked list k at a time and return its modified
/// list.
///
/// k is a positive integer and is less than or equal to the length of the linked list. If the
/// number of nodes is not a multiple of k then left-out nodes in the end should remain as it is.
///
/// Example:
/// Given this linked list: 1->2->3->4->5
/// For k = 2, you should return: 2->1->4->3->5
/// For k = 3, you should return: 3->2->1->4->5
///
/// - Note: Only constant extra memory is allowed. You may not alter the values in the list's nodes,
///     only nodes itself may be changed.

import XCTest

/// - Warning: LeetCode Swift judge is down (always gives Compiler Error) for this problem.
func reverseKGroup(_ head: ListNode?, _ k: Int) -> ListNode? {
    let dummyHead = ListNode(0)
    dummyHead.next = head
    var start: ListNode? = dummyHead
    
    // find the kth node after start
    func findEnd(for start: ListNode?) -> ListNode? {
        var end = start
        for _ in 0..<k {
            guard let next = end?.next else { return nil }
            end = next
        }
        return end
    }
    
    while let end = findEnd(for: start) {
        // first node to reverse, it is alse the last node after reverse
        let first = start?.next
        while let temp = start?.next, temp !== end {
            start?.next = temp.next
            temp.next = end.next
            end.next = temp
        }
        start?.next = end
        start = first
    }
    return dummyHead.next
}

final class ListNode {
    var val: Int
    var next: ListNode?
    init(_ val: Int) {
        self.val = val
    }
    
    init(array: [Int]) {
        guard !array.isEmpty else { fatalError() }
        val = array[0]
        var previous = self
        for i in 1..<array.count {
            let new = ListNode(array[i])
            previous.next = new
            previous = new
        }
    }
    
    func toArray() -> [Int] {
        var current: ListNode? = self
        var array: [Int] = []
        while current != nil {
            array.append(current!.val)
            current = current?.next
        }
        return array
    }
}

class Tests: XCTestCase {
    func testExample1() {
        let head = ListNode(array: [1, 2, 3, 4, 5])
        XCTAssertEqual(reverseKGroup(head, 2)?.toArray(), [2, 1, 4, 3, 5])
    }
    
    func testExample2() {
        let head = ListNode(array: [1, 2, 3, 4, 5])
        XCTAssertEqual(reverseKGroup(head, 3)?.toArray(), [3, 2, 1, 4, 5])
    }
}

Tests.defaultTestSuite.run()
