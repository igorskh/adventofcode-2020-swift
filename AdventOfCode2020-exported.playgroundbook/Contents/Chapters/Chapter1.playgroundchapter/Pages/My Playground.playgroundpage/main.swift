let expectedSum = 2020

let lines = OpenTextFile(fileName: "day1_1")
let numbers = lines[0..<lines.count-1].map { Int($0)! }.sorted()

findSum()

func findSum() {
    let cnt = numbers.count
    for i in (0..<cnt).reversed() {
        for j in 0..<i {
            let sum = numbers[i] + numbers[j]
            if sum > expectedSum {
                break
            }
            if sum == expectedSum {
                "\(numbers[i]) * \(numbers[j]) = \(numbers[i]*numbers[j])"
                return
            }
        }
    }
}
