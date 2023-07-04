//
// Created by Jordan Mavrogeorge on 7/4/23.
//

import SwiftUI

struct BottomView: View {
    @ObservedObject var state: SharedData

    func threeOAK() -> String {
        var countDictionary: [Int: Int] = [:]
        var total: Int = 0
        for dice in state.diceArray {
            total += dice.number
            countDictionary[dice.number, default: 0] += 1
        }
        let hasThree = countDictionary.values.contains { $0 >= 3 }
        if hasThree {
            return "\(total)"
        } else {
            return "0"
        }
    }

    func fourOAK() -> String {
        var countDictionary: [Int: Int] = [:]
        var total: Int = 0
        for dice in state.diceArray {
            total += dice.number
            countDictionary[dice.number, default: 0] += 1
        }
        let hasThree = countDictionary.values.contains { $0 >= 4 }
        if hasThree {
            return "\(total)"
        } else {
            return "0"
        }
    }

    func fullHouse() -> String {
        var countDictionary: [Int: Int] = [:]
        for dice in state.diceArray {
            countDictionary[dice.number, default: 0] += 1
        }
        let hasFullHouse = countDictionary.values.contains(2) && countDictionary.values.contains(3)
        if hasFullHouse {
            return "25"
        } else {
            return "0"
        }
    }

    func smStraight() -> String {
        let diceSet = Set(state.diceArray.map { $0.number }).sorted()

        guard diceSet.count >= 4 else {
            return "0"
        }

        for i in 0..<diceSet.count-3 {
            if diceSet[i+1] - diceSet[i] == 1 &&
                       diceSet[i+2] - diceSet[i+1] == 1 &&
                       diceSet[i+3] - diceSet[i+2] == 1 {
                return "30"
            }
        }
        return "0"
    }

    func lgStraight() -> String {
        let diceSet = Set(state.diceArray.map { $0.number }).sorted()

        guard diceSet.count >= 5 else {
            return "0"
        }

        for i in 0..<diceSet.count-4 {
            if diceSet[i+1] - diceSet[i] == 1 &&
                       diceSet[i+2] - diceSet[i+1] == 1 &&
                       diceSet[i+3] - diceSet[i+2] == 1 &&
                       diceSet[i+4] - diceSet[i+3] == 1 {
                return "40"
            }
        }
        return "0"
    }

    func yahtzee() -> String {
        let diceSet = Set(state.diceArray.map { $0.number });

        if diceSet.count == 1 {
            return "50"
        } else {
            return "0"
        }
    }

    func chance() -> String {
        var total = 0
        for dice in state.diceArray {
            total += dice.number
        }
        return "\(total)"
    }

    var body: some View {
        VStack {
            Text("Bottom:")
            HStack {
                Text("3 of a Kind:")
                Text(threeOAK())
            }.frame(height: 60)
            HStack {
                Text("4 of a Kind:")
                Text(fourOAK())
            }.frame(height: 60)
            HStack {
                Text("Full House:")
                Text(fullHouse())
            }.frame(height: 60)
            HStack {
                Text("Sm Straight:")
                Text(smStraight())
            }.frame(height: 60)
            HStack {
                Text("Lg Straight:")
                Text(lgStraight())
            }.frame(height: 60)
            HStack {
                Text("Yahtzee:")
                Text(yahtzee())
            }.frame(height: 60)
            HStack {
                Text("Chance:")
                Text(chance())
            }.frame(height: 60)
        }.frame(maxWidth: .infinity)
    }
}
