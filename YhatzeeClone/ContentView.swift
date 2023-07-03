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

    func InitDice() {
        for _ in 1...5 {
            diceArray.append(Dice(number: Int.random(in: 1...6), isLocked: false))
        }
    }

    func DiceText(index: Int) -> String {
        return "\(diceArray[index].number)"
    }

    func RollDice() {
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

    var body: some View {
        VStack {
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
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
            }
                    .disabled(CanRoll())
                    .opacity(CanRoll() ? 0.5 : 1)
        }
                .padding()
                .onAppear {
                    InitDice()
                }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
