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

    func InitDice() {
        for _ in 1...5 {
            diceArray.append(Dice(number: Int.random(in: 1...6), isLocked: false))
        }
    }

    func DiceText(index: Int) -> String {
        return "Dice \(index + 1): \(diceArray[index].number)"
    }

    func RollDice() {
        for index in diceArray.indices where !diceArray[index].isLocked {
            diceArray[index].number = Int.random(in: 1...6)
        }
    }

    var body: some View {
        VStack {
            ForEach(diceArray.indices, id: \.self) { index in
                Text(DiceText(index: index))
                    .font(.title)
                    .padding()
            }
            Button(action: RollDice) {
                Text("Roll Dice")
                        .font(.title)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
            }
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
