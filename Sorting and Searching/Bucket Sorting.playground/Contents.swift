import Foundation

let input = [5, 1, 0, 10, 8, 9, 7, 7, 5, 10, 2]
let expectedOutput = [0, 1, 2, 5, 5, 7, 7, 8, 9, 10, 10]

class Solution {
    func sort(_ input: [Int]) -> [Int] {
        guard input.count > 1, let max = input.max() else {
            return input
        }
        
        var buckets = [Int](repeating: 0, count: max + 1)
        
        for item in input {
            buckets[item] = buckets[item] + 1
        }
        
        var output = [Int]()
        buckets.enumerated().forEach { (index, value) in
            if value > 0 {
                output.append(contentsOf: [Int](repeating: index, count: value))
            }
        }
        
        return output
    } 
}

let solution = Solution()

if solution.sort(input) != expectedOutput {
    print("Fail")
}

if solution.sort([]) != [] {
    print("Fail")
}

if solution.sort([10]) != [10] {
    print("Fail")
}
 
