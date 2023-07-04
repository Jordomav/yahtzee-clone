//
//  ContentView.swift
//  YhatzeeClone
//
//  Created by Jordan Mavrogeorge on 7/2/23.
//
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var state: SharedData
    @State var rollCount: Int = 0
    @AppStorage("highscore") var highscore: String = "0"

    func InitDice() {
        for _ in 1...5 {
            state.diceArray.append(Dice(number: 0, isLocked: false))
        }
    }

    func RollDice() {
        if state.diceArray.count == 0 {
            InitDice()
        }
        if (rollCount < 3) {
            for index in state.diceArray.indices where !state.diceArray[index].isLocked {
                state.diceArray[index].number = Int.random(in: 1...6)
            }
            rollCount += 1
        }
    }

    func CanRoll() -> Bool {
        return rollCount == 3
    }

    func reset() {
        rollCount = 0
        state.diceArray.removeAll()
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
                TopView(state: state)
                BottomView(state: state)
            }
            Spacer()
            DiceRow(state: state)
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
