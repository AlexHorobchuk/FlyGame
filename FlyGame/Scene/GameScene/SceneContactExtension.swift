//
//  SceneContactExtension.swift
//  FlyGame
//
//  Created by Olha Dzhyhirei on 6/20/23.
//

import SpriteKit

extension GameScene: SKPhysicsContactDelegate {
    
    enum PhysicCollisionType {
        case playerObstacle, playerStar, playerLabirint, bulletObstacle, unknown, obstacleObstacle
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
        case (PhysicCategory.player, PhysicCategory.star), (PhysicCategory.star, PhysicCategory.player):
            return .playerStar
        case (PhysicCategory.player, PhysicCategory.labyrinth), (PhysicCategory.labyrinth, PhysicCategory.player):
            return .playerLabirint
        case (PhysicCategory.bullet, PhysicCategory.obstacle), (PhysicCategory.obstacle, PhysicCategory.bullet):
            return .bulletObstacle
        case (PhysicCategory.obstacle, PhysicCategory.obstacle), (PhysicCategory.obstacle, PhysicCategory.obstacle):
            return .obstacleObstacle
        case (_, _):
            return .unknown
        }
    }

    func collisionActionSwitch(type: PhysicCollisionType, bodyA: SKSpriteNode, bodyB: SKSpriteNode ) {
        switch type {
            
        case .playerObstacle:
            SoundManager.shared.playSound(for: .hit)
            VibrationManager.shared.vibrate(for: .medium)
            let obstacle = (bodyA.physicsBody?.categoryBitMask == PhysicCategory.obstacle ? bodyA : bodyB) as? ObstacleNode
            obstacle?.gotShot()
            player.attacked()
            viewModel.playerAttacked()
            
        case .playerStar:
            SoundManager.shared.playSound(for: .trophy)
            VibrationManager.shared.vibrate(for: .light)
            let star = (bodyA.physicsBody?.categoryBitMask == PhysicCategory.star ? bodyA : bodyB) as? StartNode
            star?.captured()
            viewModel.gotStar()
        
        case .playerLabirint:
            viewModel.hitLabirint()
            
        case .bulletObstacle:
            let bullet = (bodyA.physicsBody?.categoryBitMask == PhysicCategory.bullet ? bodyA : bodyB)
            let obstacle = (bodyA.physicsBody?.categoryBitMask == PhysicCategory.obstacle ? bodyA : bodyB) as? ObstacleNode
            bullet.removeFromParent()
            obstacle?.gotShot()
        case .unknown:
            return
        case .obstacleObstacle:
            let bodyA = bodyA as? ObstacleNode
            let bodyB = bodyB as? ObstacleNode
            bodyA?.gotShot()
            bodyB?.gotShot()
        }
    }
}
