//
//  SecondBrainApp.swift
//  SecondBrain
//
//  Created by Sarim Siddiqui on 10/28/23.
//

import SwiftUI

@main
struct SecondBrainApp: App {
    @State private var model = ViewModel()
    
    var body: some Scene {
        WindowGroup {
            Areas()
            .environment(model)
        }
        

        
        ImmersiveSpace(id:  model.fullSpaceArea){
                        FullSpaceArea()
                        .environment(model)
                }
        .immersionStyle(selection: .constant(.progressive), in: .progressive )
    }
}
