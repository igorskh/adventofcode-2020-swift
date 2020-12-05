let lines = OpenTextFile(fileName: "day5_1")

// MARK: -Part 1
var maxResult = 0
lines[0..<lines.count-1].forEach {
    let res = evalLine(line: $0)
    if res.2 > maxResult {
        maxResult = res.2
    }
}
print("Max seat ID is", maxResult)

// MARK: -Part 2
var result = [Int:Set<Int>]()
lines[0..<lines.count-1].forEach {
    let res = evalLine(line: $0)
    if result[res.0] == nil {
        result[res.0] = []
    }
    result[res.0]!.insert(res.1)
}

let fullRow = Set(0..<8)
for key in result.keys {
    if result[key]!.count < 8 {
        let missingCols = fullRow.subtracting(result[key]!)
        if missingCols.count == 1 {
            print("My seat ID is", key*8 + missingCols.first!)
        }
    }
}

func evalLine(line: String) -> (Int, Int, Int) {
    let row = findValue(line: String(line.prefix(7)), lower: "F", upper: "B", range: (0, 127))
    let column = findValue(line: String(line.suffix(3)), lower: "L", upper: "R", range: (0, 7))
    
    let seatId = row*8 + column
    return (row, column, seatId)
}

func findValue(line: String, lower: Character, upper: Character, range: (Int, Int)) -> Int {
    var range = range
    for c in line {
        let half = Double(range.0 + range.1)/2
        if c == lower {
            range.1 = Int(half.rounded(.down))
        } else if c == upper {
            range.0 = Int(half.rounded(.up))
        }
    }
    return range.0
}

//  print(evalLine(line: "FBFBBFFRLR"))
//  print(evalLine(line: "BFFFBBFRRR"))
//  print(evalLine(line: "FFFBBBFRRR"))
//  print(evalLine(line: "BBFFBBFRLL"))
