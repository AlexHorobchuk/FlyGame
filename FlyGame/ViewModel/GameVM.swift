//
//  GameVM.swift
//  FlyGame
//
//  Created by Olha Dzhyhirei on 6/18/23.
//

import Foundation

final class GameVM: ObservableObject {
    
    
    var points: Int
    var mover: MoverService?
    
    init (points: Int) {
        self.points = points
    }
}
