var lines = OpenTextFile(fileName: "day9_1")

let expectedSum = 217430975
var element = 0

var cumSum = 0
var map: [Int:Int] = [:]
var pos = (start: 0, end: 0)
for i in 0..<lines.count-1 {
    cumSum += Int(lines[i])!
    if cumSum == expectedSum {
        pos.end = i
        break
    }
    if let idx = map[cumSum - expectedSum] {
        pos.start = idx+1
        pos.end = i
        break
    }
    map[cumSum] = i
}

var min = Int(lines[pos.start])!
var max = Int(lines[pos.start])!
for i in pos.start...pos.end {
    let element = Int(lines[i])!
    if element < min {
        min = element
    }
    if element > max {
        max = element
    }
}
print(min, max, min+max)
