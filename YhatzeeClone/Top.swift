//
// Created by Jordan Mavrogeorge on 7/4/23.
//

import SwiftUI

struct TopView: View {
    @ObservedObject var state: SharedData

    func getCount(number: Int) -> String {
        var count = state.diceArray.filter { $0.number == number }.count
        return "\(count * number)"
    }

    var body: some View {
        VStack {
            Text("Top:")
            HStack {
                Text("1:")
                Text(getCount(number: 1))
            }.frame(height: 70)
            HStack {
                Text("2:")
                Text(getCount(number: 2))
            }.frame(height: 70)
            HStack {
                Text("3:")
                Text(getCount(number: 3))
            }.frame(height: 70)
            HStack {
                Text("4:")
                Text(getCount(number: 4))
            }.frame(height: 70)
            HStack {
                Text("5:")
                Text(getCount(number: 5))
            }.frame(height: 70)
            HStack {
                Text("6:")
                Text(getCount(number: 6))
            }.frame(height: 70)
        }.frame(maxWidth: .infinity)
    }
}