import Foundation

let testData = """
vJrwpWtwJgWrhcsFMMfFFhFp
jqHRNqRjqzjGDLGLrsFMfFZSrLrFZsSL
PmmdzqPrVvPwwTWBwg
wMqvLMZHhHMvwLHjbvcjnnSBnvTQFn
ttgJtRGJQctTZtZT
CrZsJsPPZsGzwwsLwLmpwMDw
"""

let url = URL(fileURLWithPath: "/Users/saravanakumars/Documents/Shared Playground Data/input_3.txt")
let content = try! String(contentsOf: url, encoding: .utf8)


struct RuckSack {
    let first: [Character]
    let second: [Character]
    
    var commonItem: Character {
        let set1 = Set(first)
        let set2 = Set(second)
        let commons = set1.intersection(set2)
        
        return commons.first!
    }
}

func getItemsFromRuckSack(content: String) -> [RuckSack] {
    
    let rawRuckSacks = content.components(separatedBy: "\n").filter({!$0.isEmpty})
    var ruckSacks = [RuckSack]()
    
    for rawRuckSack in rawRuckSacks {
        let secondSectionStartIndex = rawRuckSack.count / 2
        let first = rawRuckSack.enumerated()
            .filter({$0.offset < secondSectionStartIndex})
            .map({$1})
        let second = rawRuckSack.enumerated()
            .filter({$0.offset >= secondSectionStartIndex})
            .map({$1})
        ruckSacks.append(.init(first: first, second: second))
    }
    return ruckSacks
}

extension Character {
    
    var priority: UInt8 {
        isLowercase ? (asciiValue! - 96) : (asciiValue! - 64 + 26)
    }
}

let ruckSacks = getItemsFromRuckSack(content: content)
let value = ruckSacks.map({$0.commonItem.priority})
        .map({UInt32($0)})
        .reduce(0, +)

print("SUM OF PRIORITIES: \(value)")

/* TEST CODE */
/* for ruckSack in ruckSacks {
    print("Common item: \(ruckSack.commonItem) & unicode \(ruckSack.commonItem.priority)")
}

print("ascii value of a: \(Character("a").asciiValue! - 96)")
print("ascii value of z: \(Character("z").asciiValue! - 96)")
print("ascii value of A: \(Character("A").asciiValue! - 64 + 26)")
print("ascii value of Z: \(Character("Z").asciiValue! - 64 + 26)")

*/


// MARK: PROBLEM 2

extension RuckSack {
    
    var joined: [Character] {
        first + second
    }
}

extension Array where Element == Character {
    
    func toSet() -> Set<Element> {
        Set(self)
    }
}

let totalGroups = ruckSacks.count / 3
var badges = [Character?]()

for index in 0..<totalGroups {
    let actualIndex = index * 3
    let firstRuckSack = ruckSacks[actualIndex + 0].joined.toSet()
    let secondRuckSack = ruckSacks[actualIndex + 1].joined.toSet()
    let thirdRuckSack = ruckSacks[actualIndex + 2].joined.toSet()
    
    let result = firstRuckSack
        .intersection(secondRuckSack)
        .intersection(thirdRuckSack)
    badges.append(result.first)
}

let prioritySum = badges.compactMap({$0})
                    .map({UInt32($0.priority)})
                    .reduce(0, +)

print("Sum of priorities, of badges: \(prioritySum)")
