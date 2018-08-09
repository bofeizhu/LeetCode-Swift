/// You are given two non-empty linked lists representing two non-negative integers. The digits are
/// stored in reverse order and each of their nodes contain a single digit. Add the two numbers and
/// return it as a linked list.
///
/// You may assume the two numbers do not contain any leading zero, except the number 0 itself.

import XCTest

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

/// Approach: Elementary math
func addTwoNumbers(_ l0: ListNode?, _ l1: ListNode?) -> ListNode? {
    let dummyHead = ListNode(-1)
    var p = l0
    var q = l1
    var current: ListNode? = dummyHead
    var carry = 0
    while p != nil || q != nil {
        let x = p?.val ?? 0
        let y = q?.val ?? 0
        let sum = x + y + carry
        carry = sum / 10
        current?.next = ListNode(sum % 10)
        current = current?.next
        p = p?.next
        q = q?.next
    }
    if carry > 0 {
        current?.next = ListNode(carry)
    }
    return dummyHead.next
}

class Tests: XCTestCase {
    func testListNodeInitCorretly() {
        let elements = [2, 4, 3]
        let node = ListNode(array: elements)
        XCTAssertEqual(elements, node.toArray())
    }
    
    func testExample() {
        let l0 = ListNode(array: [2, 4, 3])
        let l1 = ListNode(array: [5, 6, 4])
        let sum = addTwoNumbers(l0, l1)
        let expected = [7, 0, 8]
        XCTAssertEqual(expected, sum?.toArray())
    }
    
    func testWhenOneOfTheInputIsNil() {
        let l = ListNode(array: [2, 4, 3])
        let sum = addTwoNumbers(l, nil)
        XCTAssertEqual(l.toArray(), sum?.toArray())
    }
}

Tests.defaultTestSuite.run()

