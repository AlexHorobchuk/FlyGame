//
//  SceneMoverExtension.swift
//  FlyGame
//
//  Created by Olha Dzhyhirei on 6/18/23.
//

import Foundation

extension GameScene : GameLogicService {
    
    func pause() {
        self.isPaused = true
    }
    
    func unpause() {
        self.isPaused = false
    }
    
    func shoot() {
        let bullet = player.shoot()
        self.addChild(bullet)
    }
    
    func move(x: CGFloat, y: CGFloat) {
        player.moveWithDirection(x: x, y: y)
    }
}
