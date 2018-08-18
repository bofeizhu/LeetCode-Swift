/// 19. Remove Nth Node From End of List
/// Given a linked list, remove the n-th node from the end of list and return its head.
///
/// Example:
/// Given linked list: 1->2->3->4->5, and n = 2.
///
/// After removing the second node from the end, the linked list becomes 1->2->3->5.
/// - Note: Given n will always be valid.

import XCTest

/// - Warning: Swift judge for this problem is down.
func removeNthFromEnd(_ head: ListNode?, _ n: Int) -> ListNode? {
    return nil
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
    func testExample() {
        let head = ListNode(array: [1, 2, 3, 4, 5])
        let result = removeNthFromEnd(head, 2)
        XCTAssertEqual(result?.toArray(), [1, 2, 3, 5])
    }
}

Tests.defaultTestSuite.run()
