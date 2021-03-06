import Foundation
 
public class Node {
    public var val: Int
    public var next: Node?
    public var random: Node?
    
    public init(_ val: Int) {
        self.val = val
        self.next = nil
        self.random = nil
    }
}

class Solution {
    var visited = [ObjectIdentifier: Node]()
    
    func getClonedNode(_ node: Node?) -> Node? {
        guard let node = node else { return nil }
        
        let key = ObjectIdentifier(node)
        if let visitedNode = visited[key] {
            return visitedNode
            
        } else {
            let newNode = Node(node.val)
            visited[key] = newNode
            return newNode
        }
    }
    
    func copyRandomList(_ head: Node?) -> Node? {
        guard let head = head else {
            return nil
        }
        
        var oldNode: Node? = head
        var newNode: Node? = Node(oldNode!.val)
        visited[ObjectIdentifier(oldNode!)] = newNode
        
        while oldNode != nil {
            newNode!.random = getClonedNode(oldNode!.random)
            newNode!.next = getClonedNode(oldNode?.next)
            
            oldNode = oldNode!.next
            newNode = newNode!.next
        }
        
        return visited[ObjectIdentifier(head)]
    }
}



let solution = Solution()

let node4 = Node(1)
node4.next = nil
node4.random = node1

let node3 = Node(10)
node3.next = node4
node3.random = node2

let node2 = Node(11)
node2.next = node3
node2.random = node4

let node1 = Node(13)
node1.next = node2
node1.random = node0

let node0 = Node(7)
node0.next = node1
node0.random = nil

iterateNode(node0)

func iterateNode(_ node: Node?) {
    guard let node = node else {
        return
    }
    
    print("Node val: \(node.val), next: \(node.next?.val), random: \(node.random?.val), \(ObjectIdentifier(node))")
    iterateNode(node.next)
}

let copy = solution.copyRandomList(node0)
print("COPY")
iterateNode(copy)

func nodesForNode(_ node: Node?) -> [Node] {
    var nodes: [Node] = []
    
    func nextNodeForNode(_ node: Node?, nodes: inout [Node]) {
        guard let node = node else {
            return
        }
        
        nodes.append(node)
        
        if let nextNode = node.next {
            nextNodeForNode(nextNode, nodes: &nodes)
        }
    }
    
    nextNodeForNode(node, nodes: &nodes)
    return nodes
}

func test_copyRandomList_deepCopyOutput() {
    let solution = Solution()
    let inputNodes = nodesForNode(node0)
    
    let outputNode = solution.copyRandomList(node0)
    let outputNodes = nodesForNode(outputNode)
    
    guard inputNodes.count == outputNodes.count else {
        print("Test Failed: count of input and output nodes do not match")
        return
    }
    
    for (index, inputNode) in inputNodes.enumerated() {
        let outputNode = outputNodes[index]
        
        if ObjectIdentifier(inputNode) == ObjectIdentifier(outputNode) {
            print("Text Failed: input and output nodes object identifier is the same")
        }
    }
}

test_copyRandomList_deepCopyOutput()
