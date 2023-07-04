//
// Created by Jordan Mavrogeorge on 7/4/23.
//

import SwiftUI
import Combine

class SharedData: ObservableObject {
    @Published var diceArray: [Dice] = [];
}