//
//  SecondBrainApp.swift
//  SecondBrain
//
//  Created by Sarim Siddiqui on 10/28/23.
//

import SwiftUI

@main
struct SecondBrainApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }

        ImmersiveSpace(id: "ImmersiveSpace") {
            ImmersiveView()
        }
    }
}
