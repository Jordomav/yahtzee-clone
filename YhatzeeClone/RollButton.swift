//
// Created by Jordan Mavrogeorge on 7/4/23.
//

import SwiftUI

struct RollButton: View {
    @ObservedObject var state: SharedData

    func InitDice() {
        for _ in 1...5 {
            state.diceArray.append(Dice(number: 0, isLocked: false))
        }
    }

    func RollDice() {
        if state.diceArray.count == 0 {
            InitDice()
        }
        if (state.rollCount < 3) {
            for index in state.diceArray.indices where !state.diceArray[index].isLocked {
                state.diceArray[index].number = Int.random(in: 1...6)
            }
            state.rollCount += 1
        }
    }

    func CanRoll() -> Bool {
        return state.rollCount == 3
    }

    var body: some View {
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
}
