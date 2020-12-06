let lines = OpenTextFile(fileName: "day6_1")
var result = 0

var currentSet = Set<Character>()
lines[0...lines.count-1].forEach {
    if $0 == "" {
        result += currentSet.count
        currentSet = Set<Character>()
    } else {
        currentSet.formUnion(Set($0))
    }
}
print(result)
