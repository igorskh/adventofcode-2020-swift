import Foundation

let lines = OpenTextFile(fileName: "day7_0")

let regexPrefix = try! NSRegularExpression(pattern: #"(.+) bags contain"#)
let regexBody = try! NSRegularExpression(pattern: #"(\d+) ([^,.]+) bag[s]{0,}"#)

var result: [String:Set<String>] = [:]

lines[0..<lines.count-1].forEach {
    let res = parseLine(line: $0)
    res.1.keys.forEach {
        if result[$0] == nil {
            result[$0] = []
        }
        result[$0]!.insert(res.0)
    }
}

let rootKey = "shiny gold"
print(traverse(bags: result[rootKey]!).count)

func traverse(bags: Set<String>) -> Set<String> {
    var res = Set<String>(bags)
    bags.forEach {
        if result[$0] != nil {
            res.formUnion(traverse(bags: result[$0]!))
        }
    }
    return Set<String>(res)
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
