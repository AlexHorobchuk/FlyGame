//
//  LabirinthLogicEctension.swift
//  FlyGame
//
//  Created by Olha Dzhyhirei on 6/21/23.
//

import Foundation

extension LabirinthScene: GameLogicService {
    func shoot() {
    }
    
    func pause() {
        self.isPaused = true
    }
    
    func unpause() {
        self.isPaused = false
    }
    
    
    func move(x: CGFloat, y: CGFloat) {
        player.moveWithDirection(x: x, y: y)
    }
}
