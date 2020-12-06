let lines = OpenTextFile(fileName: "day6_1")
var result = 0

var currentSet: [Character:Int] = [:]
var nPersons = 0
lines[0...lines.count-1].forEach {
    if $0 == "" {
        result += currentSet.keys.reduce(0, {
            $0 + (currentSet[$1]! == nPersons ? 1 : 0)
        })
        
        currentSet = [:]
        nPersons = 0
    } else {
        Set($0).forEach {
            if currentSet[$0] == nil {
                currentSet[$0] = 0
            }
            currentSet[$0]! += 1
        }
        nPersons += 1
    }
}
print(result)
