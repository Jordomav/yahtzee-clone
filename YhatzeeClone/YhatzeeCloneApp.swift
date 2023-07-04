//
//  YhatzeeCloneApp.swift
//  YhatzeeClone
//
//  Created by Jordan Mavrogeorge on 7/2/23.
//
//

import SwiftUI

@main
struct YhatzeeCloneApp: App {
    @StateObject var state = SharedData()

    var body: some Scene {
        WindowGroup {
            ContentView(state: state)
        }
    }
}
