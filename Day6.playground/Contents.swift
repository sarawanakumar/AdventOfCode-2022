import UIKit
import Foundation

let url = URL(fileURLWithPath: "/Users/saravanakumars/Documents/Shared Playground Data/input_6.txt")
let content = try! String(contentsOf: url)

extension String {
    
    func toCharSet() -> Set<Character> {
        .init(self)
    }
}

func containsUniqueCharacters(_ input: String) -> Bool {
    return input.count == input.toCharSet().count
}

func take(last count: Int, from index: Int, input: String) -> String {
    
    guard index >= count else { return String(input.dropFirst(index)) }
    
    print("index:" , index)
    let requiredEndIndex = input.index(input.startIndex, offsetBy: index - 1)
    let requiredStartIndex = input.index(input.startIndex, offsetBy: index - count)
    let res = input[requiredStartIndex...requiredEndIndex]
    print(res)
    return String(res)
}

//let input = "mjqjpqmgbljsphdztnvjfqwrcgsmlb"
let input = content

for i in 0..<input.count {
    let subString = take(last: 14, from: i, input: input)
    
    if containsUniqueCharacters(subString) {
        print("Match found at \(i)")
        break
    }
}


