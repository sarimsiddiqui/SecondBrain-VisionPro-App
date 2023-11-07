//
//  ContentView.swift
//  SecondBrain
//
//  Created by Sarim Siddiqui on 10/28/23.
//

import SwiftUI
import RealityKit
import RealityKitContent
import Foundation
struct ContentView: View {

    @State private var showImmersiveSpace = false
    @State private var immersiveSpaceIsShown = false
    @State private var currentTime = "00:00 AM"

    @Environment(\.openImmersiveSpace) var openImmersiveSpace
    @Environment(\.dismissImmersiveSpace) var dismissImmersiveSpace

    var body: some View {
        ZStack (alignment: .top) {
            Rectangle()
                .fill(
                    AngularGradient(
                        gradient: Gradient(colors: [
                            Color(red: 0.2, green: 0.4, blue: 0.8).opacity(1),
                            Color(red: 0.6, green: 0.2, blue: 0.6).opacity(1)
                        ]),
                        center: .center,
                        startAngle: .degrees(0),
                        endAngle: .degrees(360)
                    )
                )
                .blur(radius: 100)
                .opacity(0.3)
            Text("welcome.").font(.system(size: 70).bold().weight(Font.Weight.heavy))
                .foregroundColor(.white)
                .offset(y: +70)
            
            Text(currentTime).font(.system(size: 150).bold().weight(Font.Weight.heavy))
                .foregroundColor(.white)
                .offset(y: +300)
                .onAppear {
                    // Set up a timer to update the time every second
                    let timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
                        let date = Date()
                        let formatter = DateFormatter()
                        formatter.dateFormat = "h:mm a"
                        currentTime = formatter.string(from: date)
                    }
                    // Make sure to invalidate the timer when the view is no longer visible
                    RunLoop.current.add(timer, forMode: .common)
                }
                    Model3D(named: "snowfall", bundle:
                    realityKitContentBundle)
                    .padding(.bottom, 50)

                    Text("Make it Snow")

                    Toggle("Show ImmersiveSpace", isOn:
                        $showImmersiveSpace)
                        .toggleStyle(.button)
                        .padding(.top, 50)
                }
        .onChange(of: showImmersiveSpace) { _, newValue in
            Task {
                if newValue {
                    await openImmersiveSpace(id:
                        "ImmersiveSpace")
                } else {
                    await dismissImmersiveSpace()
                }
            }
            
        }
    }
}

#Preview(windowStyle: .automatic) {
    ContentView()

}
