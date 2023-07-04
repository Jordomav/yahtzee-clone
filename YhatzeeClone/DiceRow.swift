//
// Created by Jordan Mavrogeorge on 7/4/23.
//

import SwiftUI

struct DiceRow: View {
    @ObservedObject var state: SharedData

    func DiceText(index: Int) -> String {
        return "\(state.diceArray[index].number)"
    }

    var body: some View {
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
    }
}
