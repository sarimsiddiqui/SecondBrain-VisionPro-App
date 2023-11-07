//
//  SpaceAreaCard.swift
//  SecondBrain
//
//  Created by Sarim Siddiqui on 10/29/23.
//

import SwiftUI


struct SpaceAreaCard: View {
    @Binding var isShowing: Bool
    let openCard: () async -> Void
    let dismissCard: () async -> Void
    
    var body: some View {
        VStack {
        
            Toggle(isShowing ? "Hide Immersive Experience" : "Show Immersive Experience", isOn: $isShowing)
                .onChange(of: isShowing, initial: false) { isShowing, initial in
                    Task {
                        if !isShowing {
                            await openCard()
                        } else {
                            await dismissCard()
                        }
                    }
                }
                .toggleStyle(.button)
                .padding(25)
        }
        .glassBackgroundEffect()
    }
}

