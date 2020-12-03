let lines = OpenTextFile(fileName: "day3_1")

var grid_size = (x: lines[0].count, y: lines.count)

func count_tress(step_size: (x: Int, y: Int)) -> Int {
    var pos = (x: 0, y: 0)
    var trees_count = 0
    while pos.y < lines.count-2 {
        pos.x += step_size.x
        pos.y += step_size.y
        
        if lines[pos.y][pos.x % grid_size.x] == "#" {
            trees_count += 1
        }
    }
    return trees_count
}

// MARK: - Part1
count_tress(step_size: (x: 3, y: 1))

// MARK: - Part2
var result = 1
for step_size in [(x: 1, y: 1), (x: 3, y: 1), (x: 5, y: 1), (x: 7, y: 1), (x: 1, y: 2)] as [(x: Int, y: Int)] {
    result *= count_tress(step_size: step_size)
}
print(result)

