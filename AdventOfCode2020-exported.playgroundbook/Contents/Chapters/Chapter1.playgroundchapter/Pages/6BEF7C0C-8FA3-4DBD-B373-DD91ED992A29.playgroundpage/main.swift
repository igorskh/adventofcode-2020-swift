import Foundation

let lines = OpenTextFile(fileName: "day7_1")

let regexPrefix = try! NSRegularExpression(pattern: #"(.+) bags contain"#)
let regexBody = try! NSRegularExpression(pattern: #"(\d+) ([^,.]+) bag[s]{0,}"#)

var result: [String:[String:Int]] = [:]

lines[0..<lines.count-1].forEach {
    let res = parseLine(line: $0)
    if result[res.0] == nil {
        result[res.0] = [:]
    }
    res.1.keys.forEach {
        result[res.0]![$0] = res.1[$0]!
    }
}

let rootKey = "shiny gold"
print(traverse(key: rootKey))

func traverse(key: String) -> Int {
    var res = 0
    result[key]?.keys.forEach {
        res += result[key]![$0]!
        if result[$0] != nil {
            res += result[key]![$0]!*traverse(key: $0)
        }
    }
    return res
}

func parseLine(line: String) -> (String, [String:Int]) {
    let range = NSRange(location: 0, length: line.utf16.count)
    let match = regexPrefix.firstMatch(in: line, options: [], range: range)
    let main = String(line[Range(match!.range(at: 1), in: line)!])
    
    var dict: [String:Int] = [:]
    let matches = regexBody.matches(in: line, options: [], range: range)
    matches.enumerated().forEach {
        let bagName = String(line[Range($0.element.range(at: 2), in: line)!])
        dict[bagName] = Int(line[Range($0.element.range(at: 1), in: line)!])!
    }
    return (main, dict)
}
