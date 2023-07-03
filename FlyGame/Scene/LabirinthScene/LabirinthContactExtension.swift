//
//  LabirinthContactExtension.swift
//  FlyGame
//
//  Created by Olha Dzhyhirei on 6/22/23.
//

import SpriteKit

extension LabirinthScene: SKPhysicsContactDelegate {
    
    enum PhysicCollisionType {
        case playerObstacle, playerTrophy, bulletObstacle, unknown, bulletBoundry, playerStar
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        guard let bodyA = contact.bodyA.node as? SKSpriteNode else { return print("nil") }
        guard let bodyB = contact.bodyB.node as? SKSpriteNode else { return print("nil") }
        let type = detectCollisionType(bodyA: bodyA, bodyB: bodyB)
        collisionActionSwitch(type: type, bodyA: bodyA, bodyB: bodyB)
    }

    func detectCollisionType(bodyA: SKSpriteNode, bodyB: SKSpriteNode ) -> PhysicCollisionType {
        switch (bodyA.physicsBody?.categoryBitMask, bodyB.physicsBody?.categoryBitMask) {
        case (PhysicCategory.player, PhysicCategory.obstacle), (PhysicCategory.obstacle, PhysicCategory.player):
            return .playerObstacle
        case (PhysicCategory.player, PhysicCategory.labyrinth), (PhysicCategory.labyrinth, PhysicCategory.player):
            return .playerTrophy
        case (PhysicCategory.bullet, PhysicCategory.obstacle), (PhysicCategory.obstacle, PhysicCategory.bullet):
            return .bulletObstacle
        case (PhysicCategory.bullet, PhysicCategory.boundry), (PhysicCategory.boundry, PhysicCategory.bullet):
            return .bulletBoundry
        case (PhysicCategory.player, PhysicCategory.star), (PhysicCategory.star, PhysicCategory.player):
            return .playerStar
        case (_, _):
            return .unknown
        }
    }

    func collisionActionSwitch(type: PhysicCollisionType, bodyA: SKSpriteNode, bodyB: SKSpriteNode ) {
        switch type {
            
        case .playerObstacle:
            VibrationManager.shared.vibrate(for: .medium)
            SoundManager.shared.playSound(for: .hit)
            let obstacle = (bodyA.physicsBody?.categoryBitMask == PhysicCategory.obstacle ? bodyA : bodyB) as? EnemyNode
            obstacle?.gotShot()
            player.attacked()
            viewModel.playerAttacked()
            
        case .playerStar:
            SoundManager.shared.playSound(for: .trophy)
            VibrationManager.shared.vibrate(for: .light)
            let star = (bodyA.physicsBody?.categoryBitMask == PhysicCategory.star ? bodyA : bodyB) as? StartNode
            star?.captured()
            viewModel.gotStar()
            
        case .playerTrophy:
            VibrationManager.shared.vibrate(for: .light)
            SoundManager.shared.playSound(for: .trophy)
            viewModel.hitLabirint()
            
        case .bulletObstacle:
            let bullet = (bodyA.physicsBody?.categoryBitMask == PhysicCategory.bullet ? bodyA : bodyB)
            let enemy = (bodyA.physicsBody?.categoryBitMask == PhysicCategory.obstacle ? bodyA : bodyB) as? EnemyNode
            bullet.removeFromParent()
            enemy?.gotShot()
            
        case .bulletBoundry:
            let bullet = (bodyA.physicsBody?.categoryBitMask == PhysicCategory.bullet ? bodyA : bodyB)
            bullet.removeFromParent()
            
        case .unknown:
            return
        }
    }
}
