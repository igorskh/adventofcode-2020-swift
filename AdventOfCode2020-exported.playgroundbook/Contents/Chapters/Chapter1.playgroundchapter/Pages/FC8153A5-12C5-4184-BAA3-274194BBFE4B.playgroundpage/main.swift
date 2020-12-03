import Foundation

let regex = try! NSRegularExpression(pattern: #"(\d+)-(\d+) (\S): (\S+)"#)
struct PasswordInput {
    init?(line: String) {
        var letter: String = ""
        var pos1: Int = 0
        var pos2: Int = 0
        
        var str: String = ""
        
        let range = NSRange(location: 0, length: line.utf16.count)
        guard let match = regex.firstMatch(in: line, options: [], range: range) else {
            return nil
        }
        
        if let rng = Range(match.range(at: 1), in: line) {
            pos1 = Int(line[rng])!
        }
        if let rng = Range(match.range(at: 2), in: line) {
            pos2 = Int(line[rng])!
        }
        if let rng = Range(match.range(at: 3), in: line) {
            letter = String(line[rng])
        }
        if let rng = Range(match.range(at: 4), in: line) {
            str = String(line[rng])
        }
        
        guard (str[pos1-1] == Character(letter)) != (str[pos2-1] == Character(letter)) else {
            return nil
        }
    }
}

let lines = OpenTextFile(fileName: "day2_1")

let result = lines.flatMap {
    PasswordInput(line: $0)
}
result.count
