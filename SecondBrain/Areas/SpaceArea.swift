//
//  SpaceArea.swift
//  SecondBrain
//
//  Created by Sarim Siddiqui on 10/29/23.
//

import SwiftUI

struct SpaceArea: View {
    
    @Environment(ViewModel.self) private var model
    @Environment(\.openWindow) private var openWindow
    @Environment(\.dismissWindow) private var dismissWindow
    @Environment(\.openImmersiveSpace) private var openImmersiveSpace
    @Environment(\.dismissImmersiveSpace) private var dismissImmersiveSpace
    
    var body: some View {
        @Bindable var model = model
        
        HStack {
            
            SpaceAreaCard(isShowing: $model.isShowingSpace) {
                await openImmersiveSpace(id: model.fullSpaceArea)
                        } dismissCard: {
                            await dismissImmersiveSpace()
                        }
        }
    }
}

#Preview {
    SpaceArea()
        .environment(ViewModel())
}
