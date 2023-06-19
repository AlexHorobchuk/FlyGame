//
//  SceneMoverExtension.swift
//  FlyGame
//
//  Created by Olha Dzhyhirei on 6/18/23.
//

import Foundation

extension GameScene : MoverService {
    
    func move(x: CGFloat, y: CGFloat) {
        guard let player = getPlayer() else { return }
        player.moveWithDirection(x: x, y: y)
    }
}
