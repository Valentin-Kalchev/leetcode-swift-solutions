 
 // Definition for a binary tree node.
 
 public class TreeNode {
    public var val: Int
    public var left: TreeNode?
    public var right: TreeNode?
    
    public init(_ val: Int = 0, _ left: TreeNode? = nil, _ right: TreeNode? = nil) {
        self.val = val
        self.left = left
        self.right = right
    }
}
 
 struct Stack<T> {
    private var array: [T?] = []
    
    func printStack() -> String {
        return array.compactMap { (node) -> String? in
            if let node = node as? TreeNode {
                return "\(node.val)"
            } else {
                return nil
            }
        }.joined(separator: ",")
    }
    
    mutating func push(_ item: T?) {
        array.append(item)
    }
    
    mutating func pop() -> T?? {
        if let last = array.popLast() {
            return last
        } else {
            return nil
        }
    }
    
    func peek() -> T?? {
        return array.last
    }
    
    func isEmpty() -> Bool {
        return array.isEmpty
    }
 }
 
 // Approach 1: Recursion
 /*
class Solution {
    private func helper(_ node: TreeNode?, lower: Int?, upper: Int?) -> Bool {
        guard let node = node else {
            return true
        }
        
        let val = node.val
        
        if let lower = lower, val <= lower {
            return false
        }
        
        if let upper = upper, val >= upper {
            return false
        }
        
        if !helper(node.right, lower: val, upper: upper)  {
            return false
        }
        
        if !helper(node.left, lower: lower, upper: val)  {
            return false
        }
        
        return true
    }
    
    func isValidBST(_ root: TreeNode?) -> Bool {
        return helper(root, lower: nil, upper: nil)
    }
}
 */
 
// Approach 2: Iteration
 /*
 
 class Solution {
     private var stack = Stack<TreeNode>()
     private var uppers: [Int?] = []
     private var lowers: [Int?] = []
    
    
    func update(root: TreeNode?, lower: Int? = nil, upper: Int? = nil) {
        stack.push(root)
        lowers.append(lower)
        uppers.append(upper)
    }
     
     func isValidBST(_ root: TreeNode?) -> Bool {
        var lower: Int? = nil
        var upper: Int? = nil
        
        var root = root
        var val = root?.val
        
        update(root: root)
        
        while !stack.isEmpty() {
            root = stack.pop()!
            
            lower = lowers.popLast()!
            upper = uppers.popLast()!
            
            if root == nil {
                continue
            }
            
            val = root!.val
            print("Value: \(val)")
            
            if let val = val {
                if let lower = lower, val <= lower {
                    print("Failed at val: \(val) with lower: \(lower)")
                    return false
                }
                
                if let upper = upper, val >= upper {
                    print("Failed at val: \(val) with upper: \(upper)")
                    return false
                }
            }
            
            update(root: root?.right, lower: val, upper: upper)
            update(root: root?.left, lower: lower, upper: val)
        }
        
        return true
     }
 }
  */
 
 // Approach 3: Iteration + Stack
 class Solution {
    func isValidBST(_ root: TreeNode?) -> Bool {
        var stack = Stack<TreeNode>()
        var inorder = -Int.max
        var root = root
        
        while !stack.isEmpty() || root != nil {
            while root != nil {
                stack.push(root)
                root = root?.left
            }
            
            stack.printStack()
            root = stack.pop()!
             
            if let root = root {
                if root.val <= inorder {
                    return false
                } else {
                    inorder = root.val
                }
            }
            
            root = root?.right
        }
        
        return true
    }
 }

 /*
  5
   / \
  1   4
     / \
    3   6
  
 let node6 = TreeNode(6)
 let node3 = TreeNode(3)
 let node4 = TreeNode(4, node3, node6)
 let node1 = TreeNode(1)
 let root = TreeNode(5, node1, node4)
 let expectedOutput = false
 
 */
 
/*
   2
   / \
  1   3
  */
 /*
 let node3 = TreeNode(3)
 let node1 = TreeNode(1)
 let root = TreeNode(2, node1, node3)
 let expectedOutput = true
 */
 
 /*
                 8
               /   \
              7     9
            /
           5
         /  \
        4    6
       /
      2
     / \
    1   3
  */
 
 
 let node6 = TreeNode(6)
 let node3 = TreeNode(3)
 let node1 = TreeNode(1)
 let node2 = TreeNode(2, node1, node3)
 let node4 = TreeNode(4, node2)
 let node5 = TreeNode(5, node4, node6)
 let node7 = TreeNode(7, node5)
 let node9 = TreeNode(9)
 let root = TreeNode(8, node7, node9)
 let expectedOutput = true
 
 
 let solution = Solution()
 
 
 if solution.isValidBST(root) != expectedOutput {
    print("Wrong answer")
 }
