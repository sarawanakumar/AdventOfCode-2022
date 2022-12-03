import Foundation

let url = URL(fileURLWithPath: "/Users/saravanakumars/Documents/Shared Playground Data/input_1.1.txt")
let content = try! String(contentsOf: url, encoding: .utf8)

func parseElves(input: String) {
    
    let elves = input.components(separatedBy: "\n\n")
    var elvesCalories = [[Int]]() // [[56,45], [45,67]]
    
    for elf in elves {
        let elfCalorie = elf.components(separatedBy: "\n").compactMap(Int.init) // [[Int]]
        elvesCalories.append(elfCalorie)
    }
    
    var calorieCount = [Int]() // [121212,34334]
    
    for elvesCalorie in elvesCalories {
        let sumOfCalorie = elvesCalorie.reduce(0, +)
        calorieCount.append(sumOfCalorie)
    }
    
    let max = calorieCount.max()
    
    print(max) // Problem 1
    
    let sorted = calorieCount.sorted(by: >)
    let countOfTopThree = sorted[0...2].reduce(0, +)
    
    print(countOfTopThree) // Problem 2
}

parseElves(input: content)

/*
Optional(69310)
206104
*/
