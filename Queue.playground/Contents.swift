import Foundation

struct Queue<T>  {
    private var array: [T]
    init(_ array: [T] = []) {
        self.array = array
    }
    
    var isEmpty: Bool {
        return array.isEmpty
    }
    
    var count: Int {
        return array.count
    }
    
    mutating func enqueue(_ element: T) {
        array.append(element)
    }
    
    mutating func dequeue() -> T? {
        if isEmpty {
            return nil
        } else {
            return array.removeFirst()
        }
    }
    
    func peek() -> T? {
        return array.first
    }
}

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

func traverseNode(_ node: TreeNode, destination: Int) -> TreeNode? {
    var visitedNodes: [Int] = []
    
    var queue = Queue<TreeNode>([])
    queue.enqueue(node)
    
    if node.val == destination {
        return node
    } else {
        visitedNodes.append(node.val)
    }
    
    while let node = queue.dequeue() {
        if node.val == destination {
            return node
        }
        
        if let left = node.left, !visitedNodes.contains(left.val) {
            visitedNodes.append(left.val)
            queue.enqueue(left)
        }
        
        if let right = node.right, !visitedNodes.contains(right.val) {
            visitedNodes.append(right.val)
            queue.enqueue(right)
        }
    }
    
    print(visitedNodes)
    return nil
}


let node6 = TreeNode(6)
let node3 = TreeNode(3)
let node1 = TreeNode(1)
let node2 = TreeNode(2, node1, node3)
let node4 = TreeNode(4, node2)
let node5 = TreeNode(5, node4, node6)
let node7 = TreeNode(7, node5)
let node9 = TreeNode(9)
let root = TreeNode(8, node7, node9)

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

//let node3 = TreeNode(3)
//let node2 = TreeNode(2, node3)
//let node1 = TreeNode(1, nil, node2)

traverseNode(root, destination: 12)
