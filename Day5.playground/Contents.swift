import UIKit
struct StackContainer {
    var stackDict = [Int: [String]]()
    
    init() {
        initialStack()
    }
    
    mutating func setValue(dict: [Int: [String]]) {
        self.stackDict = dict
    }
    
    mutating func initialStack() {
        stackDict[1] = ["B", "V", "S", "N", "T", "C", "H", "Q"]
        stackDict[2] = ["W", "E", "B", "G"]
        stackDict[3] = ["F", "W", "R", "T", "S", "Q", "B"]
        stackDict[4] = ["L", "G", "W", "S", "Z", "J", "D", "N"]
        stackDict[5] = ["M", "P", "D", "V", "F"]
        stackDict[6] = ["F", "W", "J"]
        stackDict[7] = ["L", "N", "Q", "B", "J", "V"]
        stackDict[8] = ["G", "T", "R", "C", "J", "Q", "S", "N"]
        stackDict[9] = ["J", "S", "Q", "C", "W", "D", "M"]
    }
    
    mutating func push(_ el: String, onStackIndex index: Int) {
        stackDict[index]?.append(el)
    }
    
    mutating func pop(stackIndex index: Int) -> String {
        stackDict[index]?.removeLast() ?? ""
    }
    
    mutating func move(_ count: Int, fromStackIndex: Int, toStackIndex: Int) {
        
        for _ in 0..<count {
            let el = pop(stackIndex: fromStackIndex)
            push(el, onStackIndex: toStackIndex)
        }
    }
    
    mutating func moveWithPositionRetained(_ count: Int, fromStackIndex: Int, toStackIndex: Int) {
        
        var tempEls = [String]()
        
        for _ in 0..<count {
            let el = pop(stackIndex: fromStackIndex)
            tempEls.append(el)
        }
        tempEls.reverse()
        for el in tempEls {
            push(el, onStackIndex: toStackIndex)
        }
    }
    
    mutating func readTop() -> String {
        var acc = ""
        
        for idx in 1...9 {
            acc += pop(stackIndex: idx)
        }
        
        print("TOP OF STACK: \(acc)")
        return acc
    }
}

let url = URL(fileURLWithPath: "/Users/saravanakumars/Documents/Shared Playground Data/input_5.txt")
let content = try! String(contentsOf: url)

struct Movement {
    let move: Int
    let from: Int
    let to: Int
}

func parseInput(input: String) -> [Movement] {
    let inputLines = input.components(separatedBy: "\n").dropLast()
    let splitted = inputLines.map({$0.components(separatedBy: " ")})
        .compactMap({ [Int($0[1])!, Int($0[3])!, Int($0[5])!]})
        .map({arr -> Movement in Movement(move: arr[0], from: arr[1], to: arr[2])})
//    print(splitted)
    return splitted
}

let movements = parseInput(input: content)

var container = StackContainer()

for movement in movements {
    container.move(movement.move, fromStackIndex: movement.from, toStackIndex: movement.to)
}

print(container.readTop())

var newContainer = StackContainer()

//newContainer.setValue(dict: [1: ["Z","N"], 2: ["M", "C", "D"], 3: ["P"]])
print("WITH RETAINING POSITION")
/*let newMovements = [Movement(move: 1, from: 2, to: 1),
                    .init(move: 3, from: 1, to: 3),
                    .init(move: 2, from: 2, to: 1),
                    .init(move: 1, from: 1, to: 2)]*/
for movement in movements {
    newContainer.moveWithPositionRetained(movement.move, fromStackIndex: movement.from, toStackIndex: movement.to)
}

print(newContainer.readTop())
/*
 
 [Q]         [N]             [N]
 [H]     [B] [D]             [S] [M]
 [C]     [Q] [J]         [V] [Q] [D]
 [T]     [S] [Z] [F]     [J] [J] [W]
 [N] [G] [T] [S] [V]     [B] [C] [C]
 [S] [B] [R] [W] [D] [J] [Q] [R] [Q]
 [V] [D] [W] [G] [P] [W] [N] [T] [S]
 [B] [W] [F] [L] [M] [F] [L] [G] [J]
  1   2   3   4   5   6   7   8   9


 */
