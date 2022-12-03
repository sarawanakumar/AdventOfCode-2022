import Foundation

let url = URL(fileURLWithPath: "/Users/saravanakumars/Documents/Shared Playground Data/input_2.txt")
let content = try! String(contentsOf: url, encoding: .utf8)

struct Game {
    let opponentChoice: Options
    let myChoice: Options
    
    var result: GameResult {
        switch (myChoice, opponentChoice) {
        case (.rock, .scissor),
            (.scissor, .paper),
            (.paper, .rock): return .win
        case (_, _) where myChoice == opponentChoice: return .draw
        default: return .lose
        }
    }
}

struct Game2 {
    let opponentChoice: Options
    let result: GameResult
    
    var myChoice: Options {
        switch (opponentChoice, result) {
        case (.rock, .win): return .paper
        case (.scissor, .win): return .rock
        case (.paper, .win): return .scissor
        case (_, .draw): return opponentChoice
        case (.rock, .lose): return .scissor
        case (.scissor, .lose): return .paper
        case (.paper, .lose): return .rock
        }
    }
}

enum GameResult: Int {
    case lose = 0
    case draw = 3
    case win = 6
}

extension GameResult {
    
    static func parseResult(_ str: String) -> Self {
        switch str {
        case "X":  return .lose
        case "Y":  return .draw
        case "Z":  return .win
        default: fatalError()
        }
    }
}

enum Options: Int {
    case rock = 1
    case paper = 2
    case scissor = 3
}

extension Options {
    
    static func parseOpponentChoice(_ str: String) -> Self {
        switch str {
        case "A":  return .rock
        case "B":  return .paper
        case "C":  return .scissor
        default: fatalError()
        }
    }
    
    static func parseMyChoice(_ str: String) -> Self {
        switch str {
        case "X":  return .rock
        case "Y":  return .paper
        case "Z":  return .scissor
        default: fatalError()
        }
    }
}

func getGames(input: String) -> [Game] {
    let gameArray = input.components(separatedBy: "\n")
        .filter({!$0.isEmpty})
    print(gameArray)
    let result = gameArray.map { (gameString) -> Game in // "X B"
        let choices = gameString.components(separatedBy: " ")
        return Game(opponentChoice: Options.parseOpponentChoice(choices[0]), myChoice: Options.parseMyChoice(choices[1]))
    }
    return result
}

extension Game {
    
    func score() -> Int {
        return myChoice.rawValue + result.rawValue
    }
}

func calculateScore(games: [Game]) {
    let totalScore = games.map({$0.score()}).reduce(0, +)
    print("TOTAL: \(totalScore)")
}

let games = getGames(input: content)
calculateScore(games: games)



//MARK: GAME 2

func getGames2(input: String) -> [Game2] {
    let gameArray = input.components(separatedBy: "\n")
        .filter({!$0.isEmpty}) // ["X A", Y C,]
    print(gameArray)
    let result = gameArray.map { (gameString) -> Game2 in
        let choices = gameString.components(separatedBy: " ")
        return Game2(opponentChoice: Options.parseOpponentChoice(choices[0]), result: GameResult.parseResult(choices[1]))
    }
    return result
}

extension Game2 {
    
    func score() -> Int {
        return myChoice.rawValue + result.rawValue
    }
}

func calculateScore2(games: [Game2]) {
    let totalScore = games.map({$0.score()}).reduce(0, +)
    print("TOTAL: \(totalScore)")
}

let gamess = getGames2(input: content)
calculateScore2(games: gamess)
