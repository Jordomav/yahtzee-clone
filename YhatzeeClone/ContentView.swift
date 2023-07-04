//
//  ContentView.swift
//  YhatzeeClone
//
//  Created by Jordan Mavrogeorge on 7/2/23.
//
//

import SwiftUI

struct ContentView: View {
    struct Dice {
        var number: Int
        var isLocked: Bool
    }

    @State var diceArray: [Dice] = [Dice]()
    @State var rollCount: Int = 0
    @AppStorage("highscore") var highscore: String = "0"

    func InitDice() {
        for _ in 1...5 {
            diceArray.append(Dice(number: 0, isLocked: false))
        }
    }

    func DiceText(index: Int) -> String {
        return "\(diceArray[index].number)"
    }

    func RollDice() {
        if diceArray.count == 0 {
            InitDice()
        }
        if (rollCount < 3) {
            for index in diceArray.indices where !diceArray[index].isLocked {
                diceArray[index].number = Int.random(in: 1...6)
            }
            rollCount += 1
        }
    }

    func CanRoll() -> Bool {
        return rollCount == 3
    }

    func reset() {
        rollCount = 0
        diceArray.removeAll()
    }

    func getCount(number: Int) -> String {
        var count = diceArray.filter { $0.number == number }.count
        return "\(count * number)"
    }

    func threeOAK() -> String {
        var countDictionary: [Int: Int] = [:]
        var total: Int = 0
        for dice in diceArray {
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
        for dice in diceArray {
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
        for dice in diceArray {
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
        let diceSet = Set(diceArray.map { $0.number }).sorted()

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
        let diceSet = Set(diceArray.map { $0.number }).sorted()

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
        let diceSet = Set(diceArray.map { $0.number });

        if diceSet.count == 1 {
            return "50"
        } else {
            return "0"
        }
    }

    func chance() -> String {
        var total = 0
        for dice in diceArray {
            total += dice.number
        }
        return "\(total)"
    }

    var body: some View {
        VStack {
            HStack {
                Text("High Score: \(highscore)")
                Button(action: reset) {
                    Text("Reset")
                }
            }
            HStack {
                VStack {
                    Text("Top:")
                    HStack {
                        Text("1")
                        Text(getCount(number: 1))
                    }.frame(height: 70)
                    HStack {
                        Text("2")
                        Text(getCount(number: 2))
                    }.frame(height: 70)
                    HStack {
                        Text("3")
                        Text(getCount(number: 3))
                    }.frame(height: 70)
                    HStack {
                        Text("4")
                        Text(getCount(number: 4))
                    }.frame(height: 70)
                    HStack {
                        Text("5")
                        Text(getCount(number: 5))
                    }.frame(height: 70)
                    HStack {
                        Text("6")
                        Text(getCount(number: 6))
                    }.frame(height: 70)
                }.frame(maxWidth: .infinity)
                VStack {
                    Text("Bottom:")
                    HStack {
                        Text("3 of a Kind")
                        Text(threeOAK())
                    }.frame(height: 60)
                    HStack {
                        Text("4 of a Kind")
                        Text(fourOAK())
                    }.frame(height: 60)
                    HStack {
                        Text("Full House")
                        Text(fullHouse())
                    }.frame(height: 60)
                    HStack {
                        Text("Sm Straight")
                        Text(smStraight())
                    }.frame(height: 60)
                    HStack {
                        Text("Lg Straight")
                        Text(lgStraight())
                    }.frame(height: 60)
                    HStack {
                        Text("Yahtzee")
                        Text(yahtzee())
                    }.frame(height: 60)
                    HStack {
                        Text("Chance")
                        Text(chance())
                    }.frame(height: 60)
                }.frame(maxWidth: .infinity)
            }
            Spacer()
            HStack {
                ForEach(diceArray.indices, id: \.self) { index in
                    Button(action: {
                        diceArray[index].isLocked.toggle()
                    }) {
                        Text(DiceText(index: index))
                                .font(.title)
                                .padding()
                                .frame(width: 60, height: 60)
                                .background(diceArray[index].isLocked ? Color.red : Color.blue)
                                .foregroundColor(.white)
                                .cornerRadius(10)
                    }
                }
            }
            Button(action: RollDice) {
                Text("Roll Dice")
                        .font(.title)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
            }
                    .disabled(CanRoll())
                    .opacity(CanRoll() ? 0.5 : 1)
        }
                .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
