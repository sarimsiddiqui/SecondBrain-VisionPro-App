import SwiftUI
import AVFoundation

struct AmbientArea: View {
    @State private var isRainSoundOn = false
    @State private var isBirdsSoundOn = false
    @State private var isCafeSoundOn = false
    @State private var isOceanSoundOn = false

    // Add AVAudioPlayer instances for each sound
    var rainSoundPlayer: AVAudioPlayer?
    var birdsSoundPlayer: AVAudioPlayer?
    var cafeSoundPlayer: AVAudioPlayer?
    var oceanSoundPlayer: AVAudioPlayer?

    init() {
        // Load audio files for each sound
        if let rainSoundURL = Bundle.main.url(forResource: "rain_sound", withExtension: "mp3") {
            rainSoundPlayer = try? AVAudioPlayer(contentsOf: rainSoundURL)
            rainSoundPlayer?.numberOfLoops = -1 // Loop indefinitely
            rainSoundPlayer?.prepareToPlay()
        }

        if let birdsSoundURL = Bundle.main.url(forResource: "birds_sound", withExtension: "mp3") {
            birdsSoundPlayer = try? AVAudioPlayer(contentsOf: birdsSoundURL)
            birdsSoundPlayer?.numberOfLoops = -1 // Loop indefinitely
            birdsSoundPlayer?.prepareToPlay()
        }

        if let cafeSoundURL = Bundle.main.url(forResource: "cafe_sound", withExtension: "mp3") {
            cafeSoundPlayer = try? AVAudioPlayer(contentsOf: cafeSoundURL)
            cafeSoundPlayer?.numberOfLoops = -1 // Loop indefinitely
            cafeSoundPlayer?.prepareToPlay()
        }

        if let oceanSoundURL = Bundle.main.url(forResource: "ocean_sound", withExtension: "mp3") {
            oceanSoundPlayer = try? AVAudioPlayer(contentsOf: oceanSoundURL)
            oceanSoundPlayer?.numberOfLoops = -1 // Loop indefinitely
            oceanSoundPlayer?.prepareToPlay()
        }
    }

    var body: some View {
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
        VStack {
            
            Button(action: {
                if isRainSoundOn {
                    rainSoundPlayer?.stop()
                } else {
                    rainSoundPlayer?.play()
                }
                isRainSoundOn.toggle()
            }) {
                Text("Toggle Rain Sound \(isRainSoundOn ? "Off" : "On")").font(.system(size: 30))
            }.offset(y: -35)

            Button(action: {
                if isBirdsSoundOn {
                    birdsSoundPlayer?.stop()
                } else {
                    birdsSoundPlayer?.play()
                }
                isBirdsSoundOn.toggle()
            }) {
                Text("Toggle Birds Sound \(isBirdsSoundOn ? "Off" : "On")").font(.system(size: 30))
            }.offset(y: -25)

            Button(action: {
                if isCafeSoundOn {
                    cafeSoundPlayer?.stop()
                } else {
                    cafeSoundPlayer?.play()
                }
                isCafeSoundOn.toggle()
            }) {
                Text("Toggle Cafe Sound \(isCafeSoundOn ? "Off" : "On")").font(.system(size: 30))
            }.offset(y: -15)

            Button(action: {
                if isOceanSoundOn {
                    oceanSoundPlayer?.stop()
                } else {
                    oceanSoundPlayer?.play()
                }
                isOceanSoundOn.toggle()
            }) {
                Text("Toggle Ocean Sound \(isOceanSoundOn ? "Off" : "On")").font(.system(size: 30))
            }
        }.offset(y: -250)
    }
}

struct AmbientArea_Previews: PreviewProvider {
    static var previews: some View {
        AmbientArea()
    }
}
