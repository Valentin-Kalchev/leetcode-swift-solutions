import Foundation

/*
     You are given two non-empty linked lists representing two non-negative integers. The digits are stored in reverse order and each of their nodes contain a single digit. Add the two numbers and return it as a linked list.

     You may assume the two numbers do not contain any leading zero, except the number 0 itself.

     Example:

     Input: (2 -> 4 -> 3) + (5 -> 6 -> 4)
     Output: 7 -> 0 -> 8
     Explanation: 342 + 465 = 807.
*/

public class ListNode {
    
    public var val: Int
    public var next: ListNode?

    public init() { self.val = 0; self.next = nil; }
    public init(_ val: Int) { self.val = val; self.next = nil; }
    public init(_ val: Int, _ next: ListNode?) { self.val = val; self.next = next; }
    
    func printHierarchy() -> [Int] {
        var n: ListNode? = next
        var values: [Int] = [val]
        
        while n != nil {
            if let val = n?.val {
                values.append(val)
            }
            
            n = n?.next
        }
        
        return values
    }
}

class Solution {
    func addTwoNumbers(_ l1: ListNode?, _ l2: ListNode?) -> ListNode? {
        let dummyHead = ListNode(0)
        
        var node1 = l1
        var node2 = l2
        
        var carry = 0
        var currentHead: ListNode? = dummyHead
        
        while (node1 != nil || node2 != nil) {
            let n1Value = node1?.val ?? 0
            let n2Value = node2?.val ?? 0
            
            let value = carry + n1Value + n2Value
            carry = value / 10
            
            currentHead?.next = ListNode(value % 10)
            currentHead = currentHead?.next
            
            node1 = node1?.next
            node2 = node2?.next
        }
        
        if carry > 0 {
            currentHead?.next = ListNode(carry)
        }
        
        return dummyHead.next
    }
}

func listNodeForValues(_ values: [Int]) -> ListNode {
    var lists = values.map({ListNode($0)})
    let headNode = lists.removeLast()
    var currentHead = headNode
    
    for index in (0..<lists.count).reversed() {
        currentHead.next = lists[index]
        currentHead = lists[index]
    }
    
    return headNode
}
   
// [3, 4, 2]
// [4, 6, 5]
// [7, 0, 8]

//let l1_3 = ListNode(3)
//let l1_4 = ListNode(4, l1_3)
//let l1 = ListNode(2, l1_4)
let l1 = listNodeForValues([3, 4, 2])
print(l1.printHierarchy())

//let l2_4 = ListNode(4)
//let l2_6 = ListNode(6, l2_4)
//let l2 = ListNode(5, l2_6)
let l2 = listNodeForValues([4, 6, 5])
print(l2.printHierarchy())

let sum = Solution().addTwoNumbers(l1, l2)
print(sum?.printHierarchy())

