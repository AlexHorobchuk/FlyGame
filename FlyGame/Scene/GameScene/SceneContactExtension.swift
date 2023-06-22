//
//  SceneContactExtension.swift
//  FlyGame
//
//  Created by Olha Dzhyhirei on 6/20/23.
//

import SpriteKit

extension GameScene: SKPhysicsContactDelegate {
    
    enum PhysicCollisionType {
        case playerObstacle, playerStar, playerLabirint, bulletObstacle, unknown
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
        case (_, _):
            return .unknown
        }
    }

    func collisionActionSwitch(type: PhysicCollisionType, bodyA: SKSpriteNode, bodyB: SKSpriteNode ) {
        switch type {
            
        case .playerObstacle:
            let obstacle = bodyA.physicsBody?.categoryBitMask == PhysicCategory.obstacle ? bodyA : bodyB
            obstacle.removeFromParent()
            player.attacked()
            viewModel.playerAttacked()
            
        case .playerStar:
            let star = (bodyA.physicsBody?.categoryBitMask == PhysicCategory.star ? bodyA : bodyB) as? StartNode
            star?.captured()
            viewModel.gotStar()
        
        case .playerLabirint:
            viewModel.hitLabirint()
            
        case .bulletObstacle:
            bodyA.removeFromParent()
            bodyB.removeFromParent()
        case .unknown:
            return
        }
    }
}
