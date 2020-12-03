let expectedSum = 2020
let lines = OpenTextFile(fileName: "day1_1")
let numbers = lines[0..<lines.count-1].map { Int($0)! }.sorted() 

findSum()

func findSum() {
    let cnt = numbers.count
    for i in (0..<cnt).reversed() {
        for j in 0..<i {
            let sum2 = numbers[i] + numbers[j]
            if sum2 > expectedSum {
                break
            }
            for k in 0..<j {
                let sum = sum2 + numbers[k]
                if sum > expectedSum {
                    break
                }
                if sum == expectedSum {
                    "\(numbers[i]) * \(numbers[j]) * \(numbers[k]) = \(numbers[i]*numbers[j]*numbers[k])"
                    return
                }
            }
        }
    }
}
