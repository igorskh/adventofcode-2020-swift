let lines = OpenTextFile(fileName: "day9_1")

var preambleLength = 25
var numbers = [Int](repeating: 0, count: preambleLength)

var counter = 0
var preambleFinished = false
for line in lines {
    let element = Int(line)!
    if preambleFinished {
        if !lookForElement(array: numbers, element: element) {
            print(element)
            break
        }
    }
    numbers[counter] = element
    if !preambleFinished && counter == preambleLength-1 {
        preambleFinished = true
    }
    counter = (counter+1)%(preambleLength)
}

func lookForElement(array: [Int], element: Int) -> Bool {
    for i in 0..<preambleLength {
        for j in i+1..<preambleLength {
            if numbers[i] + numbers[j] == element {
                return true
            }
        }
    }
    return false
}
