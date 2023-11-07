//
//  NavigationToAreas.swift
//  SecondBrain
//
//  Created by Sarim Siddiqui on 10/29/23.
//

import SwiftUI
import Foundation



struct NavigationToAreas: View {
    
    @State private var currentTime = "00:00 AM"
    
    
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
            
            HStack(spacing : 25) {
                ForEach(Area.allCases) { area in
                    NavigationLink {
                        Text(area.title)
                        
                        if area == Area.audio {
                            AmbientArea()
                        }
                        else if area == Area.space {
                            SpaceArea()
                        }
                        else if area == Area.timer {
                            TimerArea()
                        }
                        
                        
                    } label : {
                        Label(area.name, systemImage: "chevron.right")
                            .font(.system(size: 25).bold().weight(Font.Weight.heavy))
                            
                    }
                    .controlSize(.extraLarge)
                }
                
            }.offset(y: 600)

        }
    }
}

#Preview {
    NavigationToAreas()
        .environment(ViewModel())
}
