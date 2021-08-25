/*
 Given a binary tree, flatten it to a linked list in-place.

 For example, given the following tree:

     1
    / \
   2   5
  / \   \
 3   4   6
 The flattened tree should look like:

 1
  \
   2
    \
     3
      \
       4
        \
         5
          \
           6
 */

import Foundation

class TreeNode {
    private(set) var val: Int
    
    var left: TreeNode?
    var right: TreeNode?
    
    init(val: Int = 0, left: TreeNode? = nil, right: TreeNode? = nil) {
        self.val = val
        self.left = left
        self.right = right
    }
}
 
struct Stack {
    enum State {
        case start, end
    }
    
    private var array: [(TreeNode?, State)] = []
    
    mutating func push(_ element: (TreeNode?, State)) {
        array.append(element)
    }
    
    mutating func pop() -> (node: TreeNode?, state: State)? {
        return array.popLast()
    }
    
    func peek() -> (TreeNode?, State)? {
        return array.last
    }
    
    func isEmpty() -> Bool {
        return array.isEmpty
    }
}

// Approach 1: Iterative Solution using Stack
/*
class Solution {
    func flatten(_ root: TreeNode?) {
         guard let root = root else {
             return
         }
        
        var tailNode: TreeNode?
        var stack = Stack()
        
        stack.push((root, .start))
        
        while !stack.isEmpty() {
            let element = stack.pop()!
            let currentNode = element.node
            let state = element.state
            
            if currentNode?.left == nil && currentNode?.right == nil {
                tailNode = currentNode
                continue
            }
            
            switch state {
            case .start:
                if let leftNode = currentNode?.left {
                    stack.push((leftNode, .end))
                    stack.push((leftNode.left, .start))
                    
                } else if let rightNode = currentNode?.right {
                    stack.push((rightNode, .start))
                }
                
            case .end:
                var rightNode = currentNode?.right
                
                if tailNode != nil {
                    tailNode!.right = rightNode
                    currentNode?.right = currentNode?.left
                    currentNode?.left = nil
                    rightNode = tailNode?.right
                }
                
                if rightNode != nil {
                    stack.push((rightNode!, .start))
                }
            }
        }
    }
}
*/

class Solution {
    func flatten(_ root: TreeNode?) -> TreeNode? {
        let rootRef = root
        var node = root
        
        while node != nil {
            if node?.left != nil {
                var rightMost: TreeNode? = node?.left
                
                while rightMost?.right != nil {
                    rightMost = rightMost?.right
                }
                rightMost?.right = node?.right
                node?.right = node?.left
                node?.left = nil
            }
            
            node = node?.right
        }
        
        return rootRef
    }
}

let node4 = TreeNode(val: 4)
let node3 = TreeNode(val: 3)
let node2 = TreeNode(val: 2, left: node3, right: node4)

let node6 = TreeNode(val: 6)
let node5 = TreeNode(val: 5, right: node6)
let node1 = TreeNode(val: 1, left: node2, right: node5)
 
let solution = Solution()

let output = solution.flatten(node1)
printTreeNode(output)

func printTreeNode(_ node: TreeNode?) {
    guard let node = node else {
        return
    }
    
    print(node.val)
    
    if let right = node.right {
        printTreeNode(right)
    }
}


