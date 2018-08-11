/// 24. Swap Nodes in Pairs
/// Given a linked list, swap every two adjacent nodes and return its head.
///
/// Example:
/// Given 1->2->3->4, you should return the list as 2->1->4->3.
/// - Note:
///     Your algorithm should use only constant extra space.
///     You may not modify the values in the list's nodes, only nodes itself may be changed.

import XCTest

func swapPairs(_ head: ListNode?) -> ListNode? {
    let dummyHead = ListNode(0)
    dummyHead.next = head
    var current: ListNode? = dummyHead
    while let left = current?.next,
          let right = left.next {
        left.next = right.next
        right.next = left
        current?.next = right
        current = left
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
    func testListNodeInitCorretly() {
        let head = ListNode(array: [1, 2, 3, 4])
        XCTAssertEqual(swapPairs(head)?.toArray(), [2, 1, 4, 3])
    }
}

Tests.defaultTestSuite.run()
