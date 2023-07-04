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

    func DiceText(index: Int) -> String {
        return "\(state.diceArray[index].number)"
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
            HStack {
                ForEach(state.diceArray.indices, id: \.self) { index in
                    Button(action: {
                        state.diceArray[index].isLocked.toggle()
                    }) {
                        Text(DiceText(index: index))
                                .font(.title)
                                .padding()
                                .frame(width: 60, height: 60)
                                .background(state.diceArray[index].isLocked ? Color.red : Color.blue)
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
