import Foundation

/*
    Given the root of a binary tree, return the inorder traversal of its nodes' values.
*/

class TreeNode { 
    private(set) var val: Int
    private(set) var left: TreeNode?
    private(set) var right: TreeNode?
    
    init(_ val: Int = 0,_ left: TreeNode? = nil,_ right: TreeNode? = nil) {
        self.val = val
        self.left = left
        self.right = right
    }
}

struct Stack {
    private var array: [TreeNode] = []
    
    mutating func push(_ tree: TreeNode) {
        array.append(tree)
    }
    
    mutating func pop() -> TreeNode? {
        return array.popLast()
    }
    
    func isEmpty() -> Bool {
        return array.isEmpty
    }
}

class Solution {
    func inorderTraversal(_ root: TreeNode?) -> [Int] {
        var stack = Stack()
        var inorder: [Int] = []
        var root = root
        
        while !stack.isEmpty() || root != nil {
            while root != nil {
                stack.push(root!)
                root = root?.left
            }
            
            root = stack.pop()!
            inorder.append(root!.val)
            root = root?.right
        }
        
        return inorder
    }
}


/*
 Input: [1,null,2,3]
    1
     \
      2
     /
    3

 Output: [1,3,2]
 */


let node3 = TreeNode(3)
let node2 = TreeNode(2, node3)
let node1 = TreeNode(1, nil, node2)
let expectedOutput = [1,3,2]
let solution = Solution()
let output = solution.inorderTraversal(node1)

if output != expectedOutput {
    print("Faild: \(output) not equal to \(expectedOutput)")
}
