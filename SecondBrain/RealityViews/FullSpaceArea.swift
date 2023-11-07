//
//  FullSpaceArea.swift
//  SecondBrain
//
//  Created by Sarim Siddiqui on 10/29/23.
//

import SwiftUI
import RealityKit
import RealityKitContent

struct FullSpaceArea: View {
    
    @State private var audioController: AudioPlaybackController?
       
       var body: some View {
           RealityView { content in
               guard let entity = try? await Entity(named: "Immersive", in: realityKitContentBundle) else {
                   fatalError("Unable to load immersive model")
               }
               
               let ambientAudioEntity = entity.findEntity(named: "AmbientAudio")
               
               guard let resource = try? await AudioFileResource(named: "/Root/Lofi_wav", from: "Immersive.usda", in: realityKitContentBundle) else {
                   fatalError("Unable to load lofi.wav audio resource")
               }
               
               ambientAudioEntity?.ambientAudio?.gain = 20;
               audioController = ambientAudioEntity?.prepareAudio(resource)
               audioController?.play()
               
               content.add(entity)
           }
           .onDisappear(perform: {
               audioController?.stop()
           })
       }
}

#Preview {
    FullSpaceArea()
        .environment(ViewModel())
}
