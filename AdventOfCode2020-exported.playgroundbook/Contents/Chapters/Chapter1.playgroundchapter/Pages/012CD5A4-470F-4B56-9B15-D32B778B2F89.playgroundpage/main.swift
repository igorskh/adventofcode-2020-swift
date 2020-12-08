let lines = OpenTextFile(fileName: "day8_1")

var counter = 0
var next = 0
var visited: [Int] = []

while next >= 0 && next < lines.count {
    if visited.contains(next) {
        print(counter)
        break
    }
    let command = lines[next].split(separator: " ") 
    let value = Int(command[1])!
    
    var iter = 1
    switch command[0] {
    case "nop":
        break
    case "acc":
        counter += value
    case "jmp":
        iter = value
    default:
        break 
    }
    visited.append(next)
    next += iter
}
