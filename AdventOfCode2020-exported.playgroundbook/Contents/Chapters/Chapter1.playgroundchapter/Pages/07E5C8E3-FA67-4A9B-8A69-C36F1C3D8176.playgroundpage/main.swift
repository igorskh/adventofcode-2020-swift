import Foundation

let lines = OpenTextFile(fileName: "day4_1")

var valid_count = 0
var fields = ["ecl", "pid", "eyr", "hcl", "byr", "iyr", "cid", "hgt"]
var required = Set(fields)
required.remove(at: required.firstIndex(of: "cid")!)

let regex = try! NSRegularExpression(pattern: #"(\S{3}):(\S+)"#)

var found: [String: String] = [:]
lines[0...lines.count-1].enumerated().forEach {
    let line = $0.element
    let isLastLine = $0.offset == lines.count - 1
    if line.count == 0 || isLastLine  {
        if required.subtracting(Set(found.keys)).count == 0 
            && validateKeys(dict: found) 
        {
            valid_count += 1
        }
        
        found =  [:]
        if isLastLine {
            return
        }
    } else {
        let range = NSRange(location: 0, length: line.utf16.count)
        let matches = regex.matches(in: line, options: [], range: range)
        for m in matches {
            if let rngKey = Range(m.range(at: 1), in: line),
               let rngVal = Range(m.range(at: 2), in: line) {
                found[String(line[rngKey])] = String(line[rngVal])
            } else {
                print("Error")
            }
        }
    }
}


valid_count

    
// MARK: - Part2
//  byr (Birth Year) - four digits; at least 1920 and at most 2002.
//  iyr (Issue Year) - four digits; at least 2010 and at most 2020.
//  eyr (Expiration Year) - four digits; at least 2020 and at most 2030.
//  hgt (Height) - a number followed by either cm or in:
//  If cm, the number must be at least 150 and at most 193.
//  If in, the number must be at least 59 and at most 76.
//  hcl (Hair Color) - a # followed by exactly six characters 0-9 or a-f.
//  ecl (Eye Color) - exactly one of: amb blu brn gry grn hzl oth.
//  pid (Passport ID) - a nine-digit number, including leading zeroes.

func validateKeys(dict: [String: String]) -> Bool {
    let validation = [
        "byr": try! NSRegularExpression(pattern: #"\d{4}"#),
        "iyr": try! NSRegularExpression(pattern: #"\d{4}"#),
        "eyr": try! NSRegularExpression(pattern: #"\d{4}"#),
        "hgt": try! NSRegularExpression(pattern: #"\d{2,3}((?:cm)|(?:in))"#),
        "hcl": try! NSRegularExpression(pattern: #"#[0-9a-f]{6}"#),
        "ecl": try! NSRegularExpression(pattern: #"(?:(?:amb)|(?:blu)|(?:brn)|(?:gry)|(?:grn)|(?:hzl)|(?:oth))"#),
        "pid": try! NSRegularExpression(pattern: #"^\d{9}$"#)
    ]
    for key in required {
        let value = found[key]!
        let range = NSRange(location: 0, length: value.utf16.count)
        
        let cnt = validation[key]!.numberOfMatches(in: value, options: [], range: range)
        if cnt == 0 {
            return false
        } else {
//              print(key, value)
        }
        
        switch key {
        case "byr":
            let conv = Int(value)!
            if conv < 1920 || conv > 2002 {
                return false
            }
        case "iyr":
            let conv = Int(value)!
            if conv < 2010 || conv > 2020 {
                return false
            }
        case "eyr":
            let conv = Int(value)!
            if conv < 2020 || conv > 2030 {
                return false
            }
        case "hgt":
            let tp = value.suffix(2)
            let conv = Int(value.prefix(value.count - tp.count))!
            if (tp == "cm" && (conv < 150 || conv > 193)) ||
                (tp == "in" && (conv < 59 || conv > 76)) {
                return false
            }
        default:
            break 
        }
    }
    return true
}
