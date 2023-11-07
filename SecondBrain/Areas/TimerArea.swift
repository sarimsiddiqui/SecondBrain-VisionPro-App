//
//  TiArea.swift
//  SecondBrain
//
//  Created by Sarim Siddiqui on 10/29/23.
//

import SwiftUI
import AVFoundation

struct TimerArea: View {
    @State private var workTime = 25
    @State private var shortBreakTime = 5
    @State private var longBreakTime = 10
    @State private var timeRemaining = 25 * 60
    @State private var timerRunning = false
    @State private var timerType = "Work"
    @State private var selectedTimerType = "Work"
    @State private var timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    @State private var audioPlayer: AVAudioPlayer?
    @State private var editingTime = false
    @State private var timeInMinutesString = "25"

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
                .edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 20) {
                Picker("Timer Type", selection: $selectedTimerType) {
                    Text("Work").tag("Work")
                    Text("Short Break").tag("Short Break")
                    Text("Long Break").tag("Long Break")
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding()
                .onChange(of: selectedTimerType) { newValue in
                    timerType = newValue
                    updateTimeBasedOnSelectedTimerType()
                }
                
                Text(timerType)
                    .font(.largeTitle)
                    .foregroundColor(.white)
                
                if editingTime {
                    TextField("Time", text: $timeInMinutesString, onEditingChanged: { isEditing in
                        if !isEditing {
                            updateTimeFromMinutesString()
                        }
                    })
                    .keyboardType(.numberPad)
                    .font(.system(size: 48))
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                    .frame(width: 150, height: 60)
                    .background(Color.white.opacity(0.5))
                    .cornerRadius(10)
                } else {
                    Text(timeString(time: timeRemaining))
                        .font(.system(size: 70))
                        .foregroundColor(.white)
                        .padding()
                        .onTapGesture {
                            self.editingTime = true
                            self.timeInMinutesString = String(self.timeRemaining / 60)
                        }
                }
                
                HStack {
                    Button(action: {
                        self.startTimer()
                    }) {
                        Text("Start")
                            .foregroundColor(.white)
                            .padding()
                            .cornerRadius(10)
                            .font(.system(size: 50))
                    }
                    
                    Button(action: {
                        self.stopTimer()
                    }) {
                        Text("Stop")
                            .foregroundColor(.white)
                            .padding()
                            .cornerRadius(10)
                            .font(.system(size: 50))
                    }
                    
                    Button(action: {
                        self.resetTimer()
                    }) {
                        Text("Reset")
                            .foregroundColor(.white)
                            .padding()
                            .cornerRadius(10)
                            .font(.system(size: 50))
                    }
                }
            }
            .padding()
        }
        .onReceive(timer) { _ in
            if self.timerRunning && self.timeRemaining > 0 {
                self.timeRemaining -= 1
            } else if self.timerRunning && self.timeRemaining == 0 {
                switch timerType {
                case "Work":
                    timerType = "Short Break"
                    timeRemaining = shortBreakTime * 60
                case "Short Break":
                    timerType = "Long Break"
                    timeRemaining = longBreakTime * 60
                case "Long Break":
                    timerType = "Work"
                    timeRemaining = workTime * 60
                default:
                    break
                }
            }
        }
    }
    
    func updateTimeBasedOnSelectedTimerType() {
        switch selectedTimerType {
        case "Work":
            timeRemaining = workTime * 60
        case "Short Break":
            timeRemaining = shortBreakTime * 60
        case "Long Break":
            timeRemaining = longBreakTime * 60
        default:
            break
        }
    }
    
    func startTimer() {
        self.timerRunning = true
    }
    
    func stopTimer() {
        self.timerRunning = false
    }
    
    func resetTimer() {
        self.timerRunning = false
        self.timeRemaining = workTime * 60
        self.timerType = "Work"
    }
    
    func updateTimeFromMinutesString() {
        if let timeInMinutes = Int(self.timeInMinutesString) {
            self.timeRemaining = timeInMinutes * 60
        }
        self.editingTime = false
    }
    
    func timeString(time: Int) -> String {
        let minutes = Int(time) / 60
        let seconds = Int(time) % 60
        return String(format: "%02i:%02i", minutes, seconds)
    }
}

struct TimerArea_Previews: PreviewProvider {
    static var previews: some View {
        TimerArea()
    }
}
