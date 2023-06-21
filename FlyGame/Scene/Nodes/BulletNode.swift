//
//  BulletNode.swift
//  FlyGame
//
//  Created by Olha Dzhyhirei on 6/20/23.
//

import SpriteKit

final class BulletNode: SKSpriteNode {
    
    var radius: CGFloat = 5
    var angle: CGFloat? = nil
    
    init() {
        let texture = SKTexture(image: UIImage(systemName: "flame.fill")!)
        super.init(texture: texture, color: .clear, size: CGSize(width: radius * 2, height: radius * 2))
        setUpNode()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpNode() {
        self.zPosition = 2
        
        self.physicsBody = SKPhysicsBody(circleOfRadius: radius)
        self.physicsBody?.affectedByGravity = false
        self.physicsBody?.categoryBitMask = PhysicCategory.bullet
        self.physicsBody?.collisionBitMask = 0
        self.physicsBody?.contactTestBitMask = PhysicCategory.obstacle
        self.physicsBody?.usesPreciseCollisionDetection = true
    }
    
    func shootInDirection(direction: CGFloat) {
        
        let targetX = cos(direction) * 1200
        let targetY = sin(direction) * 1200
        
        let shootAction = SKAction.move(by: CGVector(dx: targetX, dy: -targetY), duration: 2)
        let removeAction = SKAction.removeFromParent()
        
        let sequence = SKAction.sequence([shootAction, removeAction])
        self.run(sequence)
        
    }
}
