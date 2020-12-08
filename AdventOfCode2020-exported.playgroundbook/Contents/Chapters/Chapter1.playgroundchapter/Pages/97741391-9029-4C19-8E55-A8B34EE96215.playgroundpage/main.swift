var lines = OpenTextFile(fileName: "day8_1")

let firstTry = count(lines)
print(firstTry)

for i in firstTry.2 {
    lines[i].invertCommand()
    let res = count(lines)
    if res.0 {
        print(res.1)
        break
    }
    lines[i].invertCommand()
}

extension String {
    mutating func invertCommand() {
        let command = self.split(separator: " ") 
        if command[0] == "jmp" {
            self = "nop " + command[1]
        } else if command[0] == "nop" {
            self = "jmp " + command[1]
        } 
    }
}

func count(_ lines: [String]) -> (Bool, Int, [Int]) {
    var counter = 0
    var next = 0
    var visited: [Int] = []
    
    var canChange: [Int] = []
    
    while next >= 0 && next < lines.count-1 {
        if visited.contains(next) {
            break
        }
        let command = lines[next].split(separator: " ") 
        let value = Int(command[1])!
        
        var iter = 1
        switch command[0] {
        case "nop":
            canChange.append(next)
            break
        case "acc":
            counter += value
        case "jmp":
            canChange.append(next)
            iter = value
        default:
            break 
        }
        visited.append(next)
        next += iter
    }
    return (next == lines.count-1, counter, canChange)
}
