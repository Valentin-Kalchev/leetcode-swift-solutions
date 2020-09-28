import Foundation

// Definition for a Node.
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

// O(1) space
class Solution {
    func copyRandomList(_ head: Node?) -> Node? {
        // TODO
        guard let head = head else {
            return nil
        }
        
        var ptr: Node? = head
        
        while ptr != nil {
            let newNode = Node(ptr!.val)
            newNode.next = ptr?.next
            ptr?.next = newNode
            ptr = newNode.next
        }
        
        ptr = head
        
        while ptr != nil {
            ptr?.next?.random = ptr?.random != nil ? ptr?.random?.next : nil
            ptr = ptr?.next?.next
        }
        
        
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
