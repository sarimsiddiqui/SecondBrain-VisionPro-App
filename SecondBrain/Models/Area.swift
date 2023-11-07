//
//  Area.swift
//  SecondBrain
//
//  Created by Sarim Siddiqui on 10/29/23.
//

import Foundation


enum Area : String, Identifiable, CaseIterable, Equatable
{
    case timer, space, audio
    var id : Self { self }
    var name : String { rawValue.lowercased()}
    var title : String {
        switch self {
            case.timer: "pomodoro timer."
            case.space: "face away from your desk and click on the button below."
            case.audio: "play some audio while you work"
        
        }
    }
}
