//
//  ContentView.swift
//  YhatzeeClone
//
//  Created by Jordan Mavrogeorge on 7/2/23.
//
//

import SwiftUI

struct ContentView: View {
    @State private var diceValue = 1

    var body: some View {
        VStack {
            Text("Dice Value: \(diceValue)")
                    .font(.largeTitle)
                    .padding()
            Button(action: { diceValue = Int.random(in: 1...6) }) {
                Text("Roll Dice")
                        .font(.title)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
            }
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
