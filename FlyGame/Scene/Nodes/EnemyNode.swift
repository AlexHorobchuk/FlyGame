//
//  EnemyNode.swift
//  FlyGame
//
//  Created by Olha Dzhyhirei on 6/22/23.
//

import SpriteKit

final class EnemyNode: SKSpriteNode {
    
    var radius: CGFloat = 30
    var angle: CGFloat = 0
    var isMoving = false
    
    init() {
        let texture = SKTexture(image: UIImage(systemName: "eyes")!)
        super.init(texture: texture, color: .clear, size: CGSize(width: radius * 2, height: radius * 2))
        setUpNode()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpNode() {
        self.name = "Enemy"
        self.zPosition = 3
        
        self.physicsBody = SKPhysicsBody(circleOfRadius: radius)
        self.physicsBody?.affectedByGravity = false
        self.physicsBody?.categoryBitMask = PhysicCategory.obstacle
        self.physicsBody?.collisionBitMask = PhysicCategory.boundry
        self.physicsBody?.contactTestBitMask = PhysicCategory.player | PhysicCategory.bullet
    }
    
    func follow(playerNode: PlayerNode) {
        if !isMoving {
            isMoving = true
            
            let distance = self.position.distance(point: playerNode.position)
            let time = distance / 70
            let direction = CGVector(dx: playerNode.position.x - self.position.x, dy: playerNode.position.y - self.position.y)
            let moveAction = SKAction.move(by: direction, duration: time)
            let toggleAction = SKAction.run { self.isMoving = false }
            let sequenceAction = SKAction.sequence([moveAction, toggleAction])
            self.run(sequenceAction)
        }
    }
}
