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
    @AppStorage("highscore") var highscore: String = "0"

    func reset() {
        state.rollCount = 0
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
            RollButton(state: state)
        }
                .padding()
    }
}
