/// 23. Merge k Sorted Lists
/// Merge k sorted linked lists and return it as one sorted list. Analyze and describe its
/// complexity.
///
/// Example:
/// Input: [1->4->5, 1->3->4, 2->6]
/// Output: 1->1->2->3->4->4->5->6

import XCTest

/// Approach: Merge with Divide And Conquer O(Nlogk)
func mergeKLists(_ lists: [ListNode?]) -> ListNode? {
    guard !lists.isEmpty else { return nil }
    
    func mergeTwoLists(_ l1: ListNode?, _ l2: ListNode?) -> ListNode? {
        var l1 = l1
        var l2 = l2
        let dummyHead = ListNode(Int.min)
        var current: ListNode? = dummyHead
        while let node1 = l1, let node2 = l2 {
            if node1.val < node2.val {
                current?.next = node1
                l1 = node1.next
            } else {
                current?.next = node2
                l2 = node2.next
            }
            current = current?.next
        }
        if l1 != nil {
            current?.next = l1
        } else if l2 != nil {
            current?.next = l2
        }
        return dummyHead.next
    }
    
    let count = lists.count
    var lists = lists
    var interval = 1
    while interval < count {
        for i in stride(from: 0, to: count - interval, by: interval * 2) {
            lists[i] = mergeTwoLists(lists[i], lists[i + interval])
        }
        interval *= 2
    }
    return lists[0]
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
        let l1 = ListNode(array: [1, 4, 5])
        let l2 = ListNode(array: [1, 3, 4])
        let l3 = ListNode(array: [2, 6])
        let expected = [1, 1, 2, 3, 4, 4, 5, 6]
        XCTAssertEqual(mergeKLists([l1, l2, l3])?.toArray(), expected)
    }
}

Tests.defaultTestSuite.run()
