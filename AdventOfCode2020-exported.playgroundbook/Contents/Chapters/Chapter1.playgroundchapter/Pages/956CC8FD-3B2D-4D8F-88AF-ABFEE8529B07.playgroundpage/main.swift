var lines = OpenTextFile(fileName: "day10_0")
var numbers = lines[0..<lines.count].map { Int($0)! }.sorted()

var currentRating = 0
var chain: [Int] = []

print(numbers)

var diff: [Int] = [
    numbers[0] 
]
var cumSum = 0
for i in 1..<numbers.count {
    let currentDiff = numbers[i] - numbers[i-1]
    diff.append(currentDiff)
}
print(diff)

let ones = diff.countElements(element: 1)
let threes = (diff.countElements(element: 3)+1)
print(ones, threes, ones*threes)

extension Array where Element == Int {
    func countElements(element: Element) -> Int {
        return diff.reduce(0, { res, v in res + (v == element ? 1 : 0) })
    }
}
