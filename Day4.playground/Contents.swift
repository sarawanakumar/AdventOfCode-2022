import UIKit

let url = URL(fileURLWithPath: "/Users/saravanakumars/Documents/Shared Playground Data/input_4.txt")
let content = try! String(contentsOf: url)

/*
let a = Set(1...4)
let b = Set(1...4)

let ais = a.isSubset(of: b)
let bis = b.isSubset(of: a)

print("ais \(ais)")
print("bis \(bis)")
*/

func createRanges(input: String) -> [(range1: ClosedRange<Int>, range2: ClosedRange<Int>)] {
    let lines = input.components(separatedBy: "\n").filter({!$0.isEmpty})
    let rawRangePairs = lines.map({ $0.components(separatedBy: ",") })
    let rangePairs = rawRangePairs.map { rawRangePair -> (ClosedRange<Int>, ClosedRange<Int>) in
        let firstPairValues = rawRangePair[0].components(separatedBy: "-").compactMap({Int($0)})
        let secondPairValues = rawRangePair[1].components(separatedBy: "-").compactMap({Int($0)})
        let firstRange = firstPairValues[0]...firstPairValues[1]
        let secondRange = secondPairValues[0]...secondPairValues[1]
        return (firstRange, secondRange)
    }
    return rangePairs
}

func countContainedRangePairs(ranges: [(range1: ClosedRange<Int>, range2: ClosedRange<Int>)]) -> Int {
    
    let result = ranges.filter {
        let s1 = Set($0.range1)
        let s2 = Set($0.range2)
        return s1.isSubset(of: s2) || s1.isSuperset(of: s2)
    }
    return result.count
}

let ranges = createRanges(input: content)
let res = countContainedRangePairs(ranges: ranges)


//MARK: SECTION 2

func countOverlappingRangePairs(ranges: [(range1: ClosedRange<Int>, range2: ClosedRange<Int>)]) -> Int {
    let result = ranges.filter {
        let s1 = Set($0.range1)
        let s2 = Set($0.range2)
        return s1.intersection(s2).count > 0
    }
    return result.count
}

let res2 = countOverlappingRangePairs(ranges: ranges)
