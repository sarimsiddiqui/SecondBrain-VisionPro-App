//
//  ViewModel.swift
//  SecondBrain
//
//  Created by Sarim Siddiqui on 10/29/23.
//

import Foundation


@Observable
class ViewModel {
    var navigationPath : [Area] = []
    var isShowingSpace: Bool = false
    var isShowingNotePad: Bool = false
    var fullSpaceArea: String = "FullSpaceArea"
}
