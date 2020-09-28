import Foundation

let arr1 = [1,2,3,4,5]
let arr2 = [1,2,5,7,9]
let arr3 = [1,3,4,5,8]

let output = [1, 5]

class Solution {
    func arraysIntersection(_ arr1: [Int], _ arr2: [Int], _ arr3: [Int]) -> [Int] {
        
        func setFromArray(_ array: [Int]) -> Set<Int> {
            return Set<Int>(setFromArray(array))
        }
        
        let set1 = setFromArray(arr1)
        let set2 = setFromArray(arr2)
        let set3 = setFromArray(arr3)
        let resultSet = set1.intersection(set2.intersection(set3))
        
        return Array<Int>(resultSet).sorted()
    }
}

let solution = Solution()
let result = solution.arraysIntersection(arr1, arr2, arr3)

if result != output {
    print("Fail")
}
